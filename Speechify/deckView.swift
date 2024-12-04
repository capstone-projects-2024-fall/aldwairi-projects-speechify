//
//  deckView.swift
//  Speechify
//
//  Created by Amy Ollomani
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
    @Published var words: [Int] = []
   
    
    func getWords(title: String) -> [Int]{
        if let foundDeck = decks.first(where: { $0.title == title }) {
           // print("Words for \(title): \(foundDeck.words)")
            return foundDeck.words
            
        } else {
            print("Deck with title 'noun' not found.")
        }
        return []
      
    }
    
     func readDecks()  async{
        //guard let isUserID = userHomeView.isUser?.uid else{return}
        do{
            let userDocument = try await db.collection("users").document(isUserID!).getDocument()
            guard userDocument.exists else {return}
            guard let userdecks = userDocument.data()?["decks"] as? [String:Any] else{print("user has no decks "); return }
            //print("please work \(userdecks)")
            var fetchedDecks: [Deck] = []
            
            for (key, value) in userdecks {
                //print(value)
                            // We assume 'value' is a dictionary containing deck details
                            if let deckData = value as? [String: Any],
                               let language = deckData["language"] as? String,
                               let title = deckData["title"] as? String,
                               let words = deckData["words"] as? [Int] {
                                let deck = Deck(id: key, language: language, title: title, words: words)
                                fetchedDecks.append(deck)
                                //print(fetchedDecks)
                                
                              //  print("here printing words \(deck.words)")
                            }
                self.decks = fetchedDecks
            }
            
        }catch{
            print("theres been an error reading deck: \(error.localizedDescription)")
        }
        // for deck in decks {
      //       print("1 \(deck.title)")
      //   }
         
         
        return
    }
    func writeDeck(deckTitle: String, wordIDs: [Int])  {
        let deck : [String: Any] = [
             deckTitle: [
                "language":  "eng_US", //make this for users language
                "title": deckTitle,
                "words": wordIDs
            ]
        ]
        
        // Add the deck to the main dictionary using the deck's id as the key
      
        print("checking if writeDeck works as expected: \(deckTitle) \(wordIDs)")
        let userDocRef = db.collection("users").document(isUserID!)
       
       // Writing the dictionary into a specific field
        userDocRef.setData(["decks": deck], merge: true) { error in
           if let error = error {
               print("Error writing dictionary: \(error.localizedDescription)")
           } else {
               print("Dictionary successfully written to user document.")
           }
       }
        
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
    @State private var wordIDAdded: [Int] = []
    @StateObject private var deckModel = deckViewModel()
    
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
                TextField("Add word to deck", text: $searchedWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .disableAutocorrection(true)
                // Search button (optional for manual trigger)
                Button(action:{
                    let result = searchWordDB(word: searchedWord)}
                ){
                    Text("Add")
                }
                Button(action: {
                    deckModel.writeDeck(deckTitle: deckName, wordIDs: wordIDAdded)}
                ){
                    Text("Create Deck")
                    
                }
                
                List(wordsAdded, id: \.self) { result in
                    Text(result)
                }
                
            }
            topAndBottomView()
        }
    }
    
    //returns word's phonetic for
    private func searchWordDB(word: String) -> String{
        searchedWord = word.lowercased()
        var phonetic :String?
        
        db.collection("eng_US") //make this for all languages
            .whereField("isWord", isEqualTo: searchedWord).limit(to:50)
            .getDocuments(source: .server) { (snapshot, error) in
                if let error = error {
                    print("Error searching decks: \(error)")
                    return
                }else{
                    let document = snapshot?.documents.first
                    if(document?.documentID == nil){
                        print("word not found")
                        print("Error searching decks: \(String(describing: error))")
                    }else{
                        print("Word found: \(String(describing: document?.data()))")
                        if(!wordsAdded.contains(searchedWord)){
                            wordsAdded.append(searchedWord)
                            let wordIDString = document?.documentID ?? "0"
                            let wordID = Int(wordIDString)!
                            wordIDAdded.append(wordID)
                            phonetic = document?.get("isPhonetic") as? String
                            print("Phonetic: \(String(describing: phonetic))") // This will print the phonetic representation
                        }
                    }
                    
                }
            }
        return phonetic ?? "nil"
    }
    
}
