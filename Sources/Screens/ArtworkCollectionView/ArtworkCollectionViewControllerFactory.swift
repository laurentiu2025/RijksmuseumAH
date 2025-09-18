//
//  ArtworkCollectionViewControllerFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkCollectionViewControllerFactory {
    static func makeController() -> ArtworkCollectionViewController {
#if DEBUG
        if let testUseCase = TestEnvironmentBuilder.readTestCase() {
            return makeTestController(useCase: testUseCase)
        } else {
            return makeProductionController()
        }
#else
        return makeProductionController()
#endif
    }
    
    private static func makeProductionController() -> ArtworkCollectionViewController {
        let collectionViewDelegate = ArtworkCollectionViewDelegate()
        let collectionViewDataSource = ArtworkCollectionViewDataSource()
        let viewModel = ArtworkCollectionViewModelFactory.makeModel()
        return ArtworkCollectionViewController(collectionViewDelegate: collectionViewDelegate, collectionViewDataSource: collectionViewDataSource, viewModel: viewModel)
    }
    
#if DEBUG
    static func makeTestController(useCase: RijksmuseumAHUITestCase) -> ArtworkCollectionViewController {
        let collectionViewDelegate = ArtworkCollectionViewDelegate()
        let collectionViewDataSource = ArtworkCollectionViewDataSource()
        let viewModel = ArtworkCollectionViewModelMock(useCase: useCase)
        return ArtworkCollectionViewController(collectionViewDelegate: collectionViewDelegate, collectionViewDataSource: collectionViewDataSource, viewModel: viewModel)
    }
#endif
}
