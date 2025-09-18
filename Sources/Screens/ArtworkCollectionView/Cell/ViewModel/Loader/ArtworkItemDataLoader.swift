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
        Task { [weak self] in
            guard let self = self else {
                return
            }
            
            guard let artworkReference = await loadArtworkReference(artworkId: artworkId) else {
                return
            }
            
            guard let artworkResource = await loadArtworkResource(artworkReference: artworkReference) else {
                return
            }
            
            await loadImage(artworkResource: artworkResource)
        }
    }
    
    // MARK: - Reference
    
    @MainActor
    private func loadArtworkReference(artworkId: URL) async -> ArtworkReference? {
        do {
            state = .loadingReference
            let artworkReference = try await fetchArtworkReference(artworkId: artworkId)
            state = .referenceLoaded(reference: artworkReference)
            return artworkReference
        } catch {
            let detailedError = ArtworkItemDataLoaderStateError.loadReferenceFailed(error: error)
            state = .failed(detailedError)
            return nil
        }
    }
    
    private func fetchArtworkReference(artworkId: URL) async throws -> ArtworkReference {
        let artworkDetails = try await artworkDetailsService.fetchArtworkDetails(id: artworkId)
        
        guard let title = artworkDetails.identifiedBy.first(where: { $0.type == .name }),
              let artworkShow = artworkDetails.shows.first(where: { $0.type == .visualItem }) else {
            throw ArtworkItemDataLoaderError.missingRequiredData
        }
        
        return ArtworkReference(title: title.content, imageURL: artworkShow.id)
    }
    
    // MARK: - Resource
    
    @MainActor
    private func loadArtworkResource(artworkReference: ArtworkReference) async -> ArtworkResource? {
        state = .loadingResource(reference: artworkReference)
        do {
            let artworkImageResourceId = try await fetchArtworkImageResourceId(showId: artworkReference.imageURL)
            let imageId = try await fetchArtworkImageId(id: artworkImageResourceId)
            return ArtworkResource(title: artworkReference.title, imageID: imageId)
        } catch {
            let detailedError = ArtworkItemDataLoaderStateError.loadResourceFailed(reference: artworkReference, error: error)
            state = .failed(detailedError)
            return nil
        }
    }
    
    private func fetchArtworkImageResourceId(showId: URL) async throws -> URL {
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
    
    // MARK: - Image
    
    @MainActor
    private func loadImage(artworkResource: ArtworkResource) async {
        state = .loadingImage(artworkResource: artworkResource)
        do {
            let artworkImageData = try await imageLoader.loadImage(imageId: artworkResource.imageID)
            let imageResult = ArtworkItemDataLoaderState.ImageLoadResult.success(artworkImageData)
            state = .loaded(artworkResource: artworkResource, imageResult: imageResult)
        } catch {
            let imageResult = ArtworkItemDataLoaderState.ImageLoadResult.failure(error)
            state = .loaded(artworkResource: artworkResource, imageResult: imageResult)
        }
    }
}
