//
//  deckView.swift
//  Speechify
//
//  Created by Amy Ollomani on 12/1/24.
//


import SwiftUI
import Firebase

// Model to represent each deck
struct Deck: Identifiable, Hashable {
    var id: String // The key for the deck in the original dictionary
    var language: String
    var title: String
    var words: [Int]
}
@MainActor
class deckViewModel: ObservableObject{
    @Published var decks: [Deck] = [] // Store decks
    let db = Firestore.firestore()
    let isUserID = userHomeView.isUser?.uid
    
     func readDecks()  async{
        
        //guard let isUserID = userHomeView.isUser?.uid else{return}
        
        do{
            let userDocument = try await db.collection("users").document(isUserID!).getDocument()
            guard userDocument.exists else {return}
            guard let userdecks = userDocument.data()?["decks"] as? [String:Any] else{print("user has no decks "); return }
            print("please work \(userdecks)")
            var fetchedDecks: [Deck] = []
            
            for (key, value) in userdecks {
                print(value)
                            // We assume 'value' is a dictionary containing deck details
                            if let deckData = value as? [String: Any],
                               let language = deckData["language"] as? String,
                               let title = deckData["title"] as? String,
                               let words = deckData["words"] as? [Int] {
                                let deck = Deck(id: key, language: language, title: title, words: words)
                                fetchedDecks.append(deck)
                                print(fetchedDecks)
                            }
                self.decks = fetchedDecks
            }
            // Update the @Published property on the main thread
                   // DispatchQueue.main.async {
                      
                  //  }
        }catch{
            print("theres been an error reading deck: \(error.localizedDescription)")
        }
         for deck in decks {
             print("1 \(deck.title)")
         }
        
        return
    }
    
}
struct addDeckView: View{
    @State private var deckName: String = "" // State variable for user input
    
    let db = Firestore.firestore()
    @State private var cardsAdded: [String] = [] // Array to store search results
    @State private var isLoading: Bool = false // Loading indicator
    @State private var searchedWord: String = ""
    @State private var userdecks : [String:Any] = [:]
    @State private var wordsAdded: [String] = []
    @State private var wordIDAdded: [String] = []

    
    
    
    var body: some View{
        
        ZStack{
            
            VStack {
                Spacer(minLength:50)
                HStack {
                    
                    TextField("Enter deck name", text: $deckName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .disableAutocorrection(true)
                    
                    
                }
                .padding()
                TextField("Add word to deck", text: $searchedWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .disableAutocorrection(true)
                
                
                // Search button (optional for manual trigger)
             
                Button(action: searchWordDB){
                    Text("Add")
                  
                }
                
                // Search button (optional for manual trigger)
                Button("Read decks"){
                    Task{
                        try await readDecks()
                    }
                }
                
                // Display Results
                List(wordsAdded, id: \.self) { result in
                    Text(result)
                }
                
                Button(action:writeDeck){
                    Text("Create Deck")
                        .background(Color.black)
                        .foregroundColor(.white)
                }
                
                
                
            }
            topAndBottomView()
        }
        
    }
    /*
    private func readDecks(){
        
            let isUserID = userHomeView.isUser!.uid
            let userRef =  db.collection("users")
                .document(isUserID)
                .getDocument{ (snapshot, error) in
                    if let snapshot = snapshot {
                        let decks = snapshot.get("decks")
                    }else{
                        print("error when reading decks: \(error)")
                        return
                    }
                }
                   
            }
     */
            
            
            /*
            
            userRef.getDocument{(document,error) in
                if let document = document, document.exists{
                    if let data = document.data()?["decks"] as! [String : String] as? [String: String]{
                        print("Users decks: \(data)")
                    }
                }
                
            }
        }catch{
            print("An unexpected error occurred: \(error.localizedDescription)")
        }
             
        */
    
        private func writeDeck() {
            //var userDeckname: [Deck] = []
            //userDeckname.append(Deck(title: deckName, words: []))
            //print("did this work", userDeckname)
            
            
            
     
        }
    
    
    private func searchWordDB(){
        searchedWord = searchedWord.lowercased()
        //var wordID : String?
        //print(searchedWord)
        
        db.collection("eng_US")
            .whereField("isWord", isEqualTo: searchedWord).limit(to:50)
            .getDocuments(source: .server) { (snapshot, error) in
                if let error = error {
                    print("Error searching decks: \(error)")
                    return
                }else{
                    var document = snapshot?.documents.first
                    if(document?.documentID == nil){
                        print("word not found")
                        print("Error searching decks: \(String(describing: error))")
                    }else{
                        print("Word found: \(String(describing: document?.documentID)) => \(String(describing: document?.data()))")
                        if(!wordsAdded.contains(searchedWord)){
                            wordsAdded.append(searchedWord)
                            wordIDAdded.append(document?.documentID ?? "0")
                        }
                    }
                       
                    
                    //wordID = snapshot?.documents.first?.documentID
                   // if wordID == nil{
                   //     print("word not found")
                   // }else{
                   //     print("here \(wordID)")
                   // }
                   
                     //for document in snapshot!.documents {
                    //     print("does this work? \(document.documentID) => \(document.data())")
                    
                   // }
                }
            }
    }
     
    /*
    private func searchWordDB()async throws->Bool{
            
        var found : Bool = false
            guard let isUserID = userHomeView.isUser?.uid else{return false}
            do{
                let isUserDocument = try await Firestore.firestore().collection("users").document(isUserID).getDocument()
                guard isUserDocument.exists else{return false}
                guard let language = isUserDocument.data()?["learnLanguage"] as? String else{return false}
                print(language)
                
               // isWordLanguage = getWordLanguage
               // let isEntriesCount = 39849 + 1 // get actual size
               // let isRandomID = Int.random(in: 0...isEntriesCount)
                let snapshot = try await db.collection(language).whereField("isWord", isEqualTo: searchedWord).getDocuments()
                for document in snapshot.documents {
                    print("does this work? \(document.documentID) => \(document.data())")
               
                }
                
            } catch{
                print(error.localizedDescription)
            }
        return found
        
            
        }
     */
     
    
    /*
    private func searchWordDB()async throws -> Bool{
        searchedWord = searchedWord.lowercased()
        print(searchedWord)
        
        do{
            try await db.collection("eng_US")
                .whereField("isWord", isEqualTo: searchedWord)
                .getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Error searching decks: \(error)")
                        
                    }else{
                        //print("here: \("')
                        for document in snapshot!.documents {
                            print("does this work? \(document.documentID) => \(document.data())")
                            
                        }
                        
                    }
                }
        }catch{
            print("Error search DB for word: \(error.localizedDescription)")
        }
        return false
        
        
    }
     */
    
    private func readDecks()  async throws -> [String:Any]{
        
        guard let isUserID = userHomeView.isUser?.uid else{return userdecks }
        
        do{
            let userDocument = try await db.collection("users").document(isUserID).getDocument()
            guard userDocument.exists else {return userdecks}
            guard let userdecks = userDocument.data()?["decks"] as? [String:Any] else{print("user has no decks "); return userdecks}
            print("please work \(userdecks)")
            
        }catch{
            print("theres been an error reading deck: \(error.localizedDescription)")
        }
        
   
        return userdecks
    }
    
    
    
    
}
