//
//  ContentView.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/8/24.
//

import SwiftUI

import SwiftUI

struct CategoryView: View {
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
                            NavigationLink(destination: NotecardView(category: category, notecards: categorizedNotecards[category]!)) {
                                Text(category.capitalized)
                            }
                        }
                        .navigationTitle("Categories")
        }
    }
}

struct Category_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

