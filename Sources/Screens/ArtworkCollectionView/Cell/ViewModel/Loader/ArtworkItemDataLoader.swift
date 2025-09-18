//
//  ArtworkItemDataLoader.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

class ArtworkItemDataLoader: ArtworkItemDataLoading {
    private(set) var state: ArtworkItemDataLoaderState = .idle {
        didSet {
            onStateUpdate?(state)
        }
    }
    
    var onStateUpdate: StateUpdateHandler?
    
    private let artworkDetailsService: ArtworkDetailsServicing
    private let showDetailsService: ArtworkShowDetailsServicing
    private let digitalItemService: ArtworkDigitalItemServicing
    private let imageLoader: ArtworkImageLoading
    
    init(artworkDetailsService: ArtworkDetailsServicing, showDetailsService: ArtworkShowDetailsServicing, digitalItemService: ArtworkDigitalItemServicing, imageLoader: ArtworkImageLoading) {
        self.artworkDetailsService = artworkDetailsService
        self.showDetailsService = showDetailsService
        self.digitalItemService = digitalItemService
        self.imageLoader = imageLoader
    }
    
    // MARK: - ArtworkItemDataLoading
    
    @MainActor
    func loadArtworkItem(artworkId: URL) {
        Task {
            do {
                state = .loadingTitle
                let artworkDetails = try await fetchArtworkDetails(artworkId: artworkId)
                let title = artworkDetails.title
                state = .titleLoaded(title: title)
                
                state = .loadingContent(title: title)
                let artworkDigitalItemId = try await fetchArtworkDigitalItemId(showId: artworkDetails.artworkShowId)
                let imageId = try await fetchArtworkImageId(id: artworkDigitalItemId)
                let artworkData = ArtworkViewData(title: title, imageId: imageId)
                state = .contentLoaded(artworkData: artworkData)
                
                state = .loadingImage(artworkData: artworkData)
                let artworkImageData = try await fetchArtworkImageData(id: imageId)
                state = .loaded(artworkData: artworkData, imageData: artworkImageData)
            } catch {
                state = .failed(error)
            }
        }
    }
    
    private func fetchArtworkDetails(artworkId: URL) async throws -> (title: String, artworkShowId: URL) {
        let artworkDetails = try await artworkDetailsService.fetchArtworkDetails(id: artworkId)
        
        guard let title = artworkDetails.identifiedBy.first(where: { $0.type == .name }),
              let artworkShow = artworkDetails.shows.first(where: { $0.type == .visualItem }) else {
            throw ArtworkItemDataLoaderError.missingRequiredData
        }
        
        return (title: title.content, artworkShowId: artworkShow.id)
    }
    
    private func fetchArtworkDigitalItemId(showId: URL) async throws -> URL {
        let showDetails = try await showDetailsService.fetchShowDetails(id: showId)
        
        guard let digitalItemIdentifier = showDetails.digitallyShownBy.first(where: { $0.type == .digitalObject }) else {
            throw ArtworkItemDataLoaderError.missingRequiredData
        }
        
        return digitalItemIdentifier.id
    }
    
    private func fetchArtworkImageId(id: URL) async throws -> String {
        let digitalItem = try await digitalItemService.fetchDigitalItem(id: id)
        
        guard let digitalAccessPoint = digitalItem.accessPoint.first(where: { $0.type == .digitalObject }),
              let imageId = digitalAccessPoint.id.pathComponents.dropFirst().first else {
            throw ArtworkItemDataLoaderError.missingRequiredData
        }
        
        return imageId
    }
    
    private func fetchArtworkImageData(id: String) async throws -> Data {
        return try await imageLoader.loadImage(imageId: id)
    }
}
