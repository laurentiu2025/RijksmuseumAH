//
//  ArtworkViewModelMock.swift
//  RijksmuseumAHUITests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

#if DEBUG
import Foundation

@Observable
class ArtworkViewModelMock: ArtworkViewModeling {
    var title: String {
        return "Test title"
    }
    
    private(set) var imageState: ArtworkViewImageState = .idle
    
    private let useCase: RijksmuseumAHUITestCase
    
    init(useCase: RijksmuseumAHUITestCase) {
        self.useCase = useCase
    }
    
    // MARK: - ArtworkViewModeling
    
    func fetchArtworkImageData() {
        switch useCase {
        case .artworkCollectionViewLoading,
                .artworkCollectionViewSuccess,
                .artworkCollectionViewFailure:
            break
        case .artworkViewLoading:
            imageState = .loading
        case .artworkViewSuccess:
            let imageData = ArtworkImageDataGenerator.generateImageData()
            let imageResult = ArtworkViewImageState.ImageLoadedResult.success(imageData)
            imageState = .loaded(imageResult)
        case .artworkViewFailure:
            let imageError = NSError(domain: "UI Tests", code: 0)
            let imageResult = ArtworkViewImageState.ImageLoadedResult.failure(imageError)
            imageState = .loaded(imageResult)
        }
    }
}
#endif
