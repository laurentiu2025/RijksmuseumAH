//
//  ArtworkViewModelFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

final class ArtworkViewModelFactory {
    static func makeModel(artworkResource: ArtworkResource) -> ArtworkViewModel {
        let imageDownloader = ArtworkImageLoaderFactory.makeDetailLoader()
        return ArtworkViewModel(artworkResource: artworkResource, imageDownloader: imageDownloader)
    }
}
