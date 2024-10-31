//
//  ContentView.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/8/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var notecards = loadData()
    var categorizedNotecards: [String: [Notecard]] {
        Dictionary(grouping: notecards, by: { $0.category })
    }
    var body: some View {
        NavigationView {
            /*
            VStack {
                List {
                    ForEach(notecards) { item in
                        NavigationLink(destination: NotecardDetail(notecard: item)) {
                            Text(item.word)
                        }
                    }
                }
                .listStyle(.grouped)
             
            }*/
            List(categorizedNotecards.keys.sorted(), id: \.self) { category in
                            NavigationLink(destination: CategoryView(category: category, notecards: categorizedNotecards[category]!)) {
                                Text(category.capitalized)
                            }
                        }
                        .navigationTitle("Categories")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
