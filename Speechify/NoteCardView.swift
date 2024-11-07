//
//  ContentView.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/8/24.
//

import SwiftUI

struct NoteCardView: View {
    @EnvironmentObject var data: ReadData
    @State private var searchText: String = ""  // To track search input
    @State private var wordOfTheDay: Notecard? = nil

    // Get current date components
    private var currentDateComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date())
    }
    
    // Check if it's after 5 AM
    private var isAfter5AM: Bool {
        guard let hour = currentDateComponents.hour else { return false }
        return hour >= 5
    }
    
    // Get today's date at midnight
    private var today: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    // Computed property to filter notecards based on search
    var filteredNotecards: [Notecard] {
        if searchText.isEmpty {
            return []
        } else {
            return data.notecards.filter { $0.word.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        
            VStack {
                // Search Bar
                TextField("Search...", text: $searchText, onCommit: {
                    DispatchQueue.main.async {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                    }
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if searchText.isEmpty {
                    // Show Recent and Favorite lists when no search text

                    
                    ScrollView {
                        
                        // Word of the Day Section
                        if let wordOfDay = wordOfTheDay {
                            VStack(alignment: .leading) {
                                Text("Word of the Day")
                                    .font(.headline)
                                    .padding(.leading)
                                
                                NavigationLink(destination: NotecardDetail(notecard: wordOfDay)) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(wordOfDay.word)
                                                .font(.title2)
                                                .foregroundColor(.black)
                                            Text(wordOfDay.phonetic)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 12)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                            .padding(.trailing)
                                    }
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                    .padding(.horizontal)
                                }
                                .padding(.bottom)
                            }

                    Text("Recents").font(.headline)
                    List(data.recentNotecards) { item in
                        NavigationLink(destination: NotecardDetail(notecard: item).environmentObject(ReadData())) {
                            Text(item.word)
                        }
                    }
                    
                    Text("Favorites").font(.headline)
                    List(data.favoriteNotecards) { item in
                        NavigationLink(destination: NotecardDetail(notecard: item).environmentObject(ReadData())) {
                            Text(item.word)

                        }
                        
                        // Recents Section
                        VStack(alignment: .leading) {
                            Text("Recents")
                                .font(.headline)
                                .padding(.leading)
                                .opacity(data.recentNotecards.count != 0 ? 1 : 0)
                            
                                VStack(spacing: 10) {
                                    ForEach(data.recentNotecards) { item in
                                        NavigationLink(destination: NotecardDetail(notecard: item)) {
                                            HStack {
                                                Text(item.word)
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                                    .padding(.horizontal)
                                                    .padding(.vertical, 12)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.gray)
                                                    .padding(.trailing)
                                            }
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                        }
                        
                        // Favorites Section
                        VStack(alignment: .leading) {
                            
                            Text("Favorites")
                                .font(.headline)
                                .padding(.leading)
                                .opacity(data.favoriteNotecards.count != 0 ? 1 : 0)
                            
                                VStack(spacing: 10) {
                                    ForEach(data.favoriteNotecards) { item in
                                        NavigationLink(destination: NotecardDetail(notecard: item)) {
                                            HStack {
                                                Text(item.word)
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                                    .padding(.horizontal)
                                                    .padding(.vertical, 12)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.gray)
                                                    .padding(.trailing)
                                            }
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                .padding(.top, 5)
                        }
                        .padding(.top, 6)
                        
                    }
                    .background(Color(UIColor.white)) // Background for the whole section
                    
                } else {
                    // Show filtered search results when there is search text
                    List(filteredNotecards) { item in
                        NavigationLink(destination: NotecardDetail(notecard: item).environmentObject(ReadData())) {
                            Text(item.word)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Notecards")
            .onDisappear {
                searchText = ""
            }
            .onAppear {
                // Set a random word of the day when the view appears
                if !data.notecards.isEmpty {
                    updateWordOfTheDay()
                }
            }
    }
    
    // Updated function to handle word of the day logic
    private func updateWordOfTheDay() {
        let defaults = UserDefaults.standard
        
        // Check if we have a last update date stored
        if let lastUpdateDateData = defaults.object(forKey: "lastWordOfDayUpdate") as? Date {
            let calendar = Calendar.current
            let lastUpdateDay = calendar.startOfDay(for: lastUpdateDateData)
            let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
            
            // If last update was today, or (last update was yesterday and it's before 5 AM)
            if lastUpdateDay == today || (lastUpdateDay == yesterday && !isAfter5AM) {
                // Try to load existing word
                if let savedWordData = defaults.data(forKey: "currentWordOfDay") {
                    do {
                        let savedWord = try JSONDecoder().decode(Notecard.self, from: savedWordData)
                        // Verify the word exists in our current data
                        if data.notecards.contains(where: { $0.wordID == savedWord.wordID }) {
                            wordOfTheDay = savedWord
                            return
                        }
                    } catch {
                        print("Error decoding saved word: \(error)")
                    }
                }
            }
        }
        
        // If we reach here, we need to generate a new word of the day
        // This happens when:
        // 1. There's no last update date (first time)
        // 2. Last update was before yesterday
        // 3. Last update was yesterday and it's after 5 AM
        // 4. Failed to load the saved word
        if let newWord = data.notecards.randomElement() {
            do {
                let encodedWord = try JSONEncoder().encode(newWord)
                defaults.set(encodedWord, forKey: "currentWordOfDay")
                defaults.set(today, forKey: "lastWordOfDayUpdate")
                wordOfTheDay = newWord
            } catch {
                print("Error encoding word: \(error)")
            }
        }
    }
    
}



//struct NoteCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteCardView(data: <#ReadData#>)
//    }
//}
