// Person.swift
import Foundation


struct Notecard: Codable, Identifiable{
  
    enum CodingKeys: CodingKey{
        case word
        case phonetic
        case category
        case favorite
        case audioPath
        case wordID
    }

    let word: String
    let phonetic: String
    let category: String
    let favorite: String
    let audioPath: String
    let wordID: String
    var id = UUID()
    
}

//loading from JSON and returning array of notecards

func loadData()->[Notecard]{
    guard let sourcesURL = Bundle.main.url(forResource: "English", withExtension:"json")
    else {fatalError("Could not find JSON file")}
    
    guard let languageData = try? Data(contentsOf: sourcesURL) else{
        fatalError("Could not convert data")
    }
    
    guard let notecards = try?JSONDecoder().decode([Notecard].self, from: languageData) else{
        fatalError("There was a problem decoding data....")
    }
    return notecards
    
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
