//
//  ArtworkCollectionViewModelMock.swift
//  RijksmuseumAHUITests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

#if DEBUG
import Foundation

class ArtworkCollectionViewModelMock: ArtworkCollectionViewModeling {
    var onStateChange: OnStateChangeHandler?
    
    private let useCase: RijksmuseumAHUITestCase
    
    init(useCase: RijksmuseumAHUITestCase) {
        self.useCase = useCase
    }
    
    // MARK: - ArtworkCollectionViewModeling
    
    func fetchArtworkItems() {
        switch useCase {
        case .artworkCollectionViewLoading:
            let state = ArtworkCollectionViewState.loadingInitial
            onStateChange?(state)
        case .artworkCollectionViewSuccess,
                .artworkViewLoading,
                .artworkViewSuccess,
                .artworkViewFailure:
            let artworkCollectionItem = ArtworkCollectionItemCellModelMock()
            let testID = URL(string: "https://www.google.com")!
            let next = ArtworkNextCollection(id: testID, type: .orderedCollectionPage)
            let state = ArtworkCollectionViewState.loaded(items: [artworkCollectionItem], next: next)
            onStateChange?(state)
        case .artworkCollectionViewFailure:
            let imageError = NSError(domain: "UI Tests", code: 0)
            let state = ArtworkCollectionViewState.initialLoadFailed(imageError)
            onStateChange?(state)
        }
    }
    
    func fetchMoreArtworkItems() {
        fetchArtworkItems()
    }
}
#endif
