//
//  ArtworkCollectionViewModelFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkCollectionViewModelFactory {
    static func makeModel() -> ArtworkCollectionViewModel {
        let collectionService = ArtworkCollectionServiceFactory.makeService()
        return ArtworkCollectionViewModel(collectionService: collectionService)
    }
}
