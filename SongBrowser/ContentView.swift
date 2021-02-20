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
            
            //show a promt when no text is given
            if searchText.isEmpty {
                Spacer()
                Text("Please enter a song/artist name")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            } else {
                Spacer()
            }
            

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
