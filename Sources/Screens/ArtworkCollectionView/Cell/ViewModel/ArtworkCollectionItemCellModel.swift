//
//  ArtworkCollectionItemCellModel.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkCollectionItemCellModel: ArtworkCollectionItemCellModeling {
    private(set) var state: ArtworkItemDataLoaderState = .idle {
        didSet {
            onStateUpdate?(state)
        }
    }
    
    var onStateUpdate: StateUpdateHandler?
    
    private let artworkID: URL
    private let artworkItemLoader: ArtworkItemDataLoading
    
    init(artworkID: URL, artworkItemLoader: ArtworkItemDataLoading) {
        self.artworkID = artworkID
        self.artworkItemLoader = artworkItemLoader
    }
    
    // MARK: - ArtworkCollectionItemCellModeling
    
    @MainActor
    func loadIfNeeded() {
        guard case .idle = state else {
            return
        }
        
        load()
    }
    
    private func load() {
        artworkItemLoader.onStateUpdate = { [weak self] state in
            guard let self = self else {
                return
            }
            
            self.state = state
        }
        
        artworkItemLoader.loadArtworkItem(artworkID: artworkID)
    }
}
