//
//  ArtworkItemDataLoading.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

protocol ArtworkItemDataLoading: AnyObject {
    typealias StateUpdateHandler = (ArtworkItemDataLoaderState) -> Void
    var onStateUpdate: StateUpdateHandler? { get set }
    func loadArtworkItem(artworkId: URL)
}
