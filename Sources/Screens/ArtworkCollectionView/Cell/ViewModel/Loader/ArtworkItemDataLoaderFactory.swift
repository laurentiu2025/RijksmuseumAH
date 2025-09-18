//
//  ArtworkItemDataLoaderFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

final class ArtworkItemDataLoaderFactory {
    static func makeLoader() -> ArtworkItemDataLoader {
        let artowrkDetailsService = ArtworkDetailsServiceFactory.makeService()
        let showDetailsService = ArtworkShowDetailsServiceFactory.makeService()
        let digitalItemService = ArtworkDigitalItemServiceFactory.makeService()
        let imageLoader = ArtworkImageLoaderFactory.makeThumbnailLoader()
        return ArtworkItemDataLoader(artworkDetailsService: artowrkDetailsService, showDetailsService: showDetailsService, digitalItemService: digitalItemService, imageLoader: imageLoader)
    }
}
