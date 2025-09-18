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
    func loadArtworkItem(artworkID: URL) {
        Task { [weak self] in
            guard let self = self else {
                return
            }
            
            guard let artworkReference = await loadArtworkReference(artworkID: artworkID) else {
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
    private func loadArtworkReference(artworkID: URL) async -> ArtworkReference? {
        do {
            state = .loadingReference
            let artworkReference = try await fetchArtworkReference(artworkID: artworkID)
            state = .referenceLoaded(reference: artworkReference)
            return artworkReference
        } catch {
            let detailedError = ArtworkItemDataLoaderStateError.loadReferenceFailed(error: error)
            state = .failed(detailedError)
            return nil
        }
    }
    
    private func fetchArtworkReference(artworkID: URL) async throws -> ArtworkReference {
        let artworkDetails = try await artworkDetailsService.fetchArtworkDetails(id: artworkID)
        
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
            let artworkImageResourceID = try await fetchArtworkImageResourceID(showID: artworkReference.imageURL)
            let imageID = try await fetchArtworkImageID(id: artworkImageResourceID)
            return ArtworkResource(title: artworkReference.title, imageID: imageID)
        } catch {
            let detailedError = ArtworkItemDataLoaderStateError.loadResourceFailed(reference: artworkReference, error: error)
            state = .failed(detailedError)
            return nil
        }
    }
    
    private func fetchArtworkImageResourceID(showID: URL) async throws -> URL {
        let showDetails = try await showDetailsService.fetchShowDetails(id: showID)
        
        guard let digitalItemIdentifier = showDetails.digitallyShownBy.first(where: { $0.type == .digitalObject }) else {
            throw ArtworkItemDataLoaderError.missingRequiredData
        }
        
        return digitalItemIdentifier.id
    }
    
    private func fetchArtworkImageID(id: URL) async throws -> String {
        let digitalItem = try await digitalItemService.fetchDigitalItem(id: id)
        
        guard let digitalAccessPoint = digitalItem.accessPoint.first(where: { $0.type == .digitalObject }),
              let imageID = digitalAccessPoint.id.pathComponents.dropFirst().first else {
            throw ArtworkItemDataLoaderError.missingRequiredData
        }
        
        return imageID
    }
    
    // MARK: - Image
    
    @MainActor
    private func loadImage(artworkResource: ArtworkResource) async {
        state = .loadingImage(artworkResource: artworkResource)
        do {
            let artworkImageData = try await imageLoader.loadImage(imageID: artworkResource.imageID)
            let imageResult = ArtworkItemDataLoaderState.ImageLoadResult.success(artworkImageData)
            state = .loaded(artworkResource: artworkResource, imageResult: imageResult)
        } catch {
            let imageResult = ArtworkItemDataLoaderState.ImageLoadResult.failure(error)
            state = .loaded(artworkResource: artworkResource, imageResult: imageResult)
        }
    }
}
