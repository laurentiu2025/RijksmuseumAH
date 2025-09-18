//
//  ArtworkCollectionItemCellModelFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkCollectionItemCellModelFactory {
    static func makeModel(artworkId: URL) -> ArtworkCollectionItemCellModel {
        let artworkItemLoader = ArtworkItemDataLoaderFactory.makeLoader()
        return ArtworkCollectionItemCellModel(artworkId: artworkId, artworkItemLoader: artworkItemLoader)
    }
}
