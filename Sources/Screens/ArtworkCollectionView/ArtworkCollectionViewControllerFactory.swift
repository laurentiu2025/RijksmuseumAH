//
//  ArtworkCollectionViewControllerFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkCollectionViewControllerFactory {
    static func makeController() -> ArtworkCollectionViewController {
        let collectionViewDelegate = ArtworkCollectionViewDelegate()
        let collectionViewDataSource = ArtworkCollectionViewDataSource()
        let viewModel = ArtworkCollectionViewModelFactory.makeModel()
        return ArtworkCollectionViewController(collectionViewDelegate: collectionViewDelegate, collectionViewDataSource: collectionViewDataSource, viewModel: viewModel)
    }
}
