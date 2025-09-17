//
//  ArtworkCollectionServicing.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

protocol ArtworkCollectionServicing {
    func fetchArtworkCollection() async throws -> ArtworkCollection
    func fetchNextArtworkCollection(collectionURL: URL) async throws -> ArtworkCollection
}
