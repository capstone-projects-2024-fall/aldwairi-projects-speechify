// Person.swift
import Foundation

struct Notecard: Codable, Identifiable, Equatable {
    
    enum CodingKeys: CodingKey {
        case word
        case phonetic
        case favorite
        case audioPath
        case wordID
    }

    let word: String
    let phonetic: String
    var favorite: Bool
    let audioPath: String
    let wordID: String
    var id = UUID()
    
    // Implement Equatable
    static func == (lhs: Notecard, rhs: Notecard) -> Bool {
        return lhs.wordID == rhs.wordID
    }
    
    // Decoder initialization
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        word = try container.decode(String.self, forKey: .word)
        phonetic = try container.decode(String.self, forKey: .phonetic)
        audioPath = try container.decode(String.self, forKey: .audioPath)
        wordID = try container.decode(String.self, forKey: .wordID)
        
        if let favoriteString = try? container.decode(String.self, forKey: .favorite) {
            favorite = (favoriteString == "true")
        } else {
            favorite = try container.decode(Bool.self, forKey: .favorite)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(word, forKey: .word)
        try container.encode(phonetic, forKey: .phonetic)
        try container.encode(audioPath, forKey: .audioPath)
        try container.encode(wordID, forKey: .wordID)
        try container.encode(favorite, forKey: .favorite)
    }
    
    init(word: String, phonetic: String, favorite: Bool, audioPath: String, wordID: String) {
        self.word = word
        self.phonetic = phonetic
        self.favorite = favorite
        self.audioPath = audioPath
        self.wordID = wordID
    }
}


import Foundation
import Firebase
import FirebaseFirestore

class ReadData: ObservableObject {
    @Published var notecards = [Notecard]()
    @Published var favoriteNotecards = [Notecard]()
    @Published var recentNotecards = [Notecard]()
    
    init() {
        loadData()
        updateFavorites()
    }
    
    func loadData() {
        guard let sourcesURL = Bundle.main.url(forResource: "CMUDict_Notecards", withExtension: "json") else {
            fatalError("Could not find JSON file")
        }
        
        guard let languageData = try? Data(contentsOf: sourcesURL) else {
            fatalError("Could not convert data")
        }
        
        guard let decodedNotecards = try? JSONDecoder().decode([Notecard].self, from: languageData) else {
            fatalError("There was a problem decoding data....")
        }
        
        self.notecards = decodedNotecards
        updateFavorites()
        //loadUserFavorites()
    }
    
    func updateFavorites() {
        favoriteNotecards = notecards.filter { $0.favorite }
        objectWillChange.send()
    }
    
    func addToRecent(_ notecard: Notecard) {
        // Find the current version of the notecard
        if let currentCard = notecards.first(where: { $0.wordID == notecard.wordID }) {
            if let existingIndex = recentNotecards.firstIndex(of: currentCard) {
                recentNotecards.remove(at: existingIndex)
            }
            recentNotecards.insert(currentCard, at: 0)
            
            if recentNotecards.count > 5 {
                recentNotecards = Array(recentNotecards.prefix(5))
            }
            objectWillChange.send()
        }
    }
    
    func toggleFavorite(_ notecard: Notecard) {
        guard let index = notecards.firstIndex(where: { $0.wordID == notecard.wordID }) else {
            return
        }
        
        // Toggle local favorite state
        notecards[index].favorite.toggle()
        
        // Update recent notecards if exists
        if let recentIndex = recentNotecards.firstIndex(where: { $0.wordID == notecard.wordID }) {
            recentNotecards[recentIndex].favorite = notecards[index].favorite
        }
        
        // Update Firestore
       // updateFavoriteInFirestore(notecard: notecards[index])
        
        updateFavorites()
    }
    /*
    private func updateFavoriteInFirestore(notecard: Notecard) {
        guard let currentUser = UserHomeView.isUser else {
            print("No user logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(currentUser.uid)
        
        // Determine the language collection based on some logic (you might need to adjust this)
        let language = determineLanguage(for: notecard)
        
        if notecard.favorite {
            // Add to favorites
            userRef.updateData([
                "favouriteWords": FieldValue.arrayUnion([
                    [language: Int(notecard.wordID) ?? 0]
                ])
            ]) { error in
                if let error = error {
                    print("Error adding to favorites: \(error.localizedDescription)")
                }
            }
        } else {
            // Remove from favorites
            userRef.updateData([
                "favouriteWords": FieldValue.arrayRemove([
                    [language: Int(notecard.wordID) ?? 0]
                ])
            ]) { error in
                if let error = error {
                    print("Error removing from favorites: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func loadUserFavorites() {
        guard let currentUser = UserHomeView.isUser else {
            print("No user logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(currentUser.uid)
        
        userRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            
            guard let data = document?.data(),
                  let favouriteWords = data["favouriteWords"] as? [String: [Int]] else {
                return
            }
            
            // Update local favorites based on Firestore data
            for (language, wordIDs) in favouriteWords {
                for wordID in wordIDs {
                    if let index = self.notecards.firstIndex(where: { $0.wordID == String(wordID) }) {
                        self.notecards[index].favorite = true
                    }
                }
            }
            
            self.updateFavorites()
        }
    }*/
    
    // Helper method to determine language - you'll need to implement this based on your app's logic
    private func determineLanguage(for notecard: Notecard) -> String {
        // This is a placeholder. Implement your logic to determine the language
        // For example, you might have a language property in Notecard or use some other method
        return "English" // Default fallback
    }
}

/*
//loading from JSON
class ReadData: ObservableObject {
    @Published var notecards = [Notecard]()
    @Published var favoriteNotecards = [Notecard]()
    @Published var recentNotecards = [Notecard]()

    init() {
        loadData()
        updateFavorites()
    }

    func loadData() {
        guard let sourcesURL = Bundle.main.url(forResource: "CMUDict_Notecards", withExtension: "json") else {
            fatalError("Could not find JSON file")
        }
        
        guard let languageData = try? Data(contentsOf: sourcesURL) else {
            fatalError("Could not convert data")
        }
        
        guard let decodedNotecards = try? JSONDecoder().decode([Notecard].self, from: languageData) else {
            fatalError("There was a problem decoding data....")
        }
        
        self.notecards = decodedNotecards
        updateFavorites()
    }
    
    func updateFavorites() {
        favoriteNotecards = notecards.filter { $0.favorite }
        objectWillChange.send()
    }
    
    func addToRecent(_ notecard: Notecard) {
        // Find the current version of the notecard
        if let currentCard = notecards.first(where: { $0.wordID == notecard.wordID }) {
            if let existingIndex = recentNotecards.firstIndex(of: currentCard) {
                recentNotecards.remove(at: existingIndex)
            }
            recentNotecards.insert(currentCard, at: 0)
            
            if recentNotecards.count > 5 {
                recentNotecards = Array(recentNotecards.prefix(5))
            }
            objectWillChange.send()
        }
    }
    
    func toggleFavorite(_ notecard: Notecard) {
        if let index = notecards.firstIndex(where: { $0.wordID == notecard.wordID }) {
            notecards[index].favorite.toggle()
            
            // Update the same notecard in recents if it exists
            if let recentIndex = recentNotecards.firstIndex(where: { $0.wordID == notecard.wordID }) {
                recentNotecards[recentIndex].favorite = notecards[index].favorite
            }
            
            updateFavorites()
        }
    }
}
*/
/*
func parse(jsonData: Data) -> English? {
    do {
        let decodedData = try JSONDecoder().decode(English.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}
func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

*/
