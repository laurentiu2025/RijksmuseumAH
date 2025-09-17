//
//  ArtworkCollectionItemCellModel.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkCollectionItemCellModel: ArtworkCollectionItemCellModeling {
    let artworkId: URL
    
    init(artworkId: URL) {
        self.artworkId = artworkId
    }
}
