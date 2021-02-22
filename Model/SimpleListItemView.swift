//
//  SimpleListItemView.swift
//  SongBrowser
//
//  Created by Mo Asche on 2021-02-22.
//

import SwiftUI

struct SimpleListItemView: View {
    
    var title: String
    var caption: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title.trackName)
                .font(.subheadline)
            
            
            Text(caption.artistName)
                .font(.caption)
        }
    }
}

struct SimpleListItemView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleListItemView(title: exampleSong.trackName,
                           caption: exampleSong.artistName)
    }
}
