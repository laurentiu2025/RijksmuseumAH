//
//  ArtworkItemDataLoaderState.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

enum ArtworkItemDataLoaderState {
    case idle
    case loadingTitle
    case titleLoaded(title: String)
    case loadingContent(title: String)
    case contentLoaded(artworkData: ArtworkViewData)
    case loadingImage(artworkData: ArtworkViewData)
    case loaded(artworkData: ArtworkViewData, imageData: Data)
    case failed(Error)
}
