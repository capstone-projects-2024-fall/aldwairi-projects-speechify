//
//  ContentView.swift
//  Speechify
//
//  Created by Amy Ollomani on 10/8/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @ObservedObject var datas = ReadData()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(datas.notecards) { item in
                        NavigationLink(destination: NotecardDetail(notecard: item)) {
                            Text(item.word)
                        }
                    }
                }
                .listStyle(.grouped)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
