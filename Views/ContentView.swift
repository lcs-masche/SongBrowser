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
    
    //keeps the list of songs retrieved from Apple Musoc
    @State private var songs: [Song] = []
    
    var body: some View {
        
        VStack {


            SearchBarView(text: $searchText)
                .onChange(of: searchText) { _ in
                    fetchSongResults()
                }
            
            //show a promt when no text is given
            if searchText.isEmpty {
                Spacer()
                Text("Please enter a song/artist")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            } else {
                // search text was given show list of results
                // keypath of \.tracID
                
                
                List(songs, id: \.trackId) { currentSong in
                    
                    NavigationLink(destination: SongDetailView(song: currentSong)) {
                        
                        SimpleListItemView( title: currentSong.trackName,
                                            caption: currentSong.artistName)
                    }
                        
                    
            
                    
                }
            }
            
            
        }

        .navigationTitle("Song Browser")
    }
    
    
    //FUnctions
    func fetchSongResults() {
        
        //sanitize search input
        let input = searchText.lowercased().replacingOccurrences(of: " ", with: "+")
        // Set the address of the JSON endpoint
        let url = URL(string: "https://itunes.apple.com/search?term=\(input)&entity=song")!
        
        // Configure a URLRequest instance
        // Defines what type of request will be sent to the address noted above
        var request = URLRequest(url: url)
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        // Run the request on a background thread and process the result.
        // NOTE: This occurs asynchronously.
        //       That means we don't know precisely when the request will
        //       complete.
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // When the request *does* complete, there are three parameters
            // containing data that are created:
            //
            // data
            // The data returned by the server.
            //
            // response
            // An object that provides response metadata, such as HTTP headers and status code. If you are making an HTTP or HTTPS request, the returned object is actually an HTTPURLResponse object.
            //
            // error
            // An error object that indicates why the request failed, or nil if the request was successful.
            
            
            // Verify that some data was actually returned
            guard let songData = data else {
                
                // When no data is returned, provide a descriptive error
                //
                // error?.localizedDescription is an example of "optional chaining"
                // This means that if the error object is not nil, the
                // localizedDescription property will be used
                //
                // ?? "Unknown error" is an example of the "nil coalescing" operator
                // This means that when the error object *is* nil, a default string of
                // "Unknown error" will be provided
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                // Don't continue past this point
                return
                
            }
            
            // DEBUG: See what raw JSON data was returned from the server
            //print(String(data: jokeData, encoding: .utf8)!)
            
            // Attempt to decode the JSON into an instance of the SearchResult structure
            if let decodedSongData = try? JSONDecoder().decode(SearchResult.self, from: songData) {
                
                // DEBUG:
                print("Song data decoded from JSON successfully")
                
                
                // Now, update the UI on the main thread
                DispatchQueue.main.async {
                    
                    // Assign the result to the "Songs" property
                    songs = decodedSongData.results
                    
                }
                
            } else {
                
                print("Could not decode JSON into an instance of the Search Result structure.")
                
            }
            
        }.resume()
        // NOTE: Invoking the resume() function
        // on the dataTask closure is key. The request will not
        // run, otherwise.
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

