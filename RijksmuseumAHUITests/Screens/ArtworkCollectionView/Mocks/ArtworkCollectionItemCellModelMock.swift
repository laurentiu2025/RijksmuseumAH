//
//  ArtworkCollectionItemCellModelMock.swift
//  RijksmuseumAHUITests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

#if DEBUG
import UIKit

class ArtworkCollectionItemCellModelMock: ArtworkCollectionItemCellModeling {
    private(set) var state: ArtworkItemDataLoaderState = .idle {
        didSet {
            onStateUpdate?(state)
        }
    }
    
    var onStateUpdate: StateUpdateHandler?
    
    // MARK: - ArtworkCollectionItemCellModeling
    
    func loadIfNeeded() {
        let artworkResource = ArtworkResource(title: "Test title", imageID: "test image id")
        let imageData = ArtworkImageDataGenerator.generateImageData()
        let imageResult = ArtworkItemDataLoaderState.ImageLoadResult.success(imageData)
        state = .loaded(artworkResource: artworkResource, imageResult: imageResult)
    }
}
#endif
