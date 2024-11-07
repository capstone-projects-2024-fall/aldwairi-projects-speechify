//
//  ContentView.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/8/24.
//

import SwiftUI

struct NoteCardView: View {
    @ObservedObject var data = ReadData()
    @State private var searchText: String = ""  // To track search input

    // Computed property to filter notecards based on search
    var filteredNotecards: [Notecard] {
        if searchText.isEmpty {
            return []
        } else {
            return data.notecards.filter { $0.word.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if searchText.isEmpty {
                    // Show Recent and Favorite lists when no search text
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
                    }
                } else {
                    // Show filtered search results when there is search text
                    List(filteredNotecards) { item in
                        NavigationLink(destination: NotecardDetail(notecard: item).environmentObject(ReadData())) {
                            Text(item.word)
                        }
                    }
                }
            }
            .navigationTitle("Notecards")
        }
        .environmentObject(data)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCardView()
    }
}
