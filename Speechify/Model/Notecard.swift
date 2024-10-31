// Person.swift
import Foundation

struct Notecard: Codable, Identifiable{
  
    enum CodingKeys: CodingKey{
        case word
        case phonetic
        case favorite
        case audioPath
        case wordID
    }

    let word: String
    let phonetic: String
    var favorite: String
    let audioPath: String
    let wordID: String
    var id = UUID()
    
}

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
        // Your loading code here
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
        updateFavorites() // Update after loading data
    }
    
    // Update favorites and recents lists
    func updateFavorites() {
        favoriteNotecards = notecards.filter { $0.favorite == "true" }
    }

    // Call this whenever a notecard is viewed
    func addToRecent(_ notecard: Notecard) {
        recentNotecards.removeAll { $0.wordID == notecard.wordID }
        recentNotecards.insert(notecard, at: 0)
        
        // Limit recent list to the last 5 items
        if recentNotecards.count > 5 {
            recentNotecards = Array(recentNotecards.prefix(5))
        }
    }
    func toggleFavorite(_ notecard: Notecard) {
        if let index = notecards.firstIndex(where: { $0.wordID == notecard.wordID }) {
            notecards[index].favorite = notecards[index].favorite == "true" ? "false" : "true"
            updateFavorites()
        }
    }
}


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
