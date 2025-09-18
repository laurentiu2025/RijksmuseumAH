//
//  ContentView.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedArtworkResource: ArtworkResource?
    
    var body: some View {
        NavigationStack {
            ArtworkCollectionViewWrapper { artworkResource in
                selectedArtworkResource = artworkResource
            }
            .navigationTitle("Artworks")
            .navigationDestination(item: $selectedArtworkResource) { artworkResource in
                ArtworkViewFactory.makeView(artworkResource: artworkResource)
                    .navigationTitle(artworkResource.title)
            }
        }
    }
}

#Preview {
    ContentView()
}
