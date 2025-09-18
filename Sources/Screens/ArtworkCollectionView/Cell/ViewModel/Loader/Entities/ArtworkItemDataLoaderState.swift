//
//  ArtworkItemDataLoaderState.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

enum ArtworkItemDataLoaderState {
    case idle
    case loadingReference
    case referenceLoaded(reference: ArtworkReference)
    case loadingResource(reference: ArtworkReference)
    case resourceLoaded(resource: ArtworkResource)
    case loadingImage(artworkResource: ArtworkResource)
    typealias ImageLoadResult = Result<Data, Error>
    case loaded(artworkResource: ArtworkResource, imageResult: ImageLoadResult)
    case failed(ArtworkItemDataLoaderStateError)
}
