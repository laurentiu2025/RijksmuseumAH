//
//  ContentView.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ArtworkCollectionViewWrapper { artworkData in
            print(artworkData)
        }
    }
}

#Preview {
    ContentView()
}
