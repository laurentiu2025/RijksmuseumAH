//
//  ArtworkCollectionViewModel.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkCollectionViewModel: ArtworkCollectionViewModeling {
    var onStateChange: OnStateChangeHandler?
    
    private var state: ArtworkCollectionViewState = .idle {
        didSet {
            onStateChange?(state)
        }
    }
    
    private let collectionService: ArtworkCollectionServicing
    
    init(collectionService: ArtworkCollectionServicing) {
        self.collectionService = collectionService
    }
    
    // MARK: - ArtworkCollectionViewModeling
    
    @MainActor
    func fetchArtworkItems() {
        switch state {
        case .idle,
                .initialLoadFailed:
            fetchInitialArtworkItemsUseCase()
        default:
            return
        }
    }
    
    @MainActor
    func fetchMoreArtworkItems() {
        switch state {
        case .loaded(let items, let next),
                .loadMoreFailed(let items, let next, _):
            fetchMoreArtworkItemsUseCase(existingArtworkItemViewModels: items, next: next)
        default:
            return
        }
    }
    
    // MARK: - Use cases
    
    @MainActor
    private func fetchInitialArtworkItemsUseCase() {
        Task {
            state = .loadingInitial
            do {
                let artworkCollection = try await collectionService.fetchArtworkCollection()
                let artworkItemViewModels = artworkItemViewModels(artworkItems: artworkCollection.items)
                state = .loaded(items: artworkItemViewModels, next: artworkCollection.next)
            } catch {
                state = .initialLoadFailed(error)
            }
        }
    }
    
    @MainActor
    private func fetchMoreArtworkItemsUseCase(existingArtworkItemViewModels: [ArtworkCollectionItemCellModel], next: ArtworkNextCollection) {
        Task {
            state = .loadingMore(items: existingArtworkItemViewModels, next: next)
            do {
                let artworkCollection = try await collectionService.fetchNextArtworkCollection(id: next.id)
                let artworkItemViewModels = artworkItemViewModels(artworkItems: artworkCollection.items)
                let updatedArtworkItemViewModels = existingArtworkItemViewModels + artworkItemViewModels
                state = .loaded(items: updatedArtworkItemViewModels, next: artworkCollection.next)
            } catch {
                state = .loadMoreFailed(items: existingArtworkItemViewModels, next: next, error: error)
            }
        }
    }
    
    // MARK: - Mapping
    
    private func artworkItemViewModels(artworkItems: [ArtworkItem]) -> [ArtworkCollectionItemCellModel] {
        return artworkItems.map {
            ArtworkCollectionItemCellModelFactory.makeModel(artworkID: $0.id)
        }
    }
}
