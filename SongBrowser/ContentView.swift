//
//  ContentView.swift
//  SongBrowser
//
//  Created by Mo Asche on 2021-02-20.
//

import SwiftUI

struct ContentView: View {
    
    // keeps track of what the user is searching for.
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            
            SearchBarView(text: $searchText)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
