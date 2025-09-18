//
//  ArtworkViewModel.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

@Observable
final class ArtworkViewModel: ArtworkViewModeling {
    var title: String {
        return artworkResource.title
    }
    
    private(set) var imageState: ArtworkViewImageState = .idle
    private let artworkResource: ArtworkResource
    private let imageDownloader: ArtworkImageLoading
    
    init(artworkResource: ArtworkResource, imageDownloader: ArtworkImageLoading) {
        self.artworkResource = artworkResource
        self.imageDownloader = imageDownloader
    }
    
    // MARK: - ArtworkViewModeling
    
    @MainActor
    func fetchArtworkImageData() async {
        imageState = .loading
        do {
            let imageData = try await imageDownloader.loadImage(imageId: artworkResource.imageID)
            imageState = .loaded(.success(imageData))
        } catch {
            imageState = .loaded(.failure(error))
        }
    }
}
