//
//  ArtworkCollectionService.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkCollectionService: ArtworkCollectionServicing {
    struct API {
        static let base = URL(string: "https://data.rijksmuseum.nl/search/collection")!
    }
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - ArtworkCollectionServicing
    
    func fetchArtworkCollection() async throws -> ArtworkCollection {
        let request = URLRequest(url: API.base)
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(ArtworkCollection.self, from: data)
    }
    
    func fetchNextArtworkCollection(id: URL) async throws -> ArtworkCollection {
        let request = URLRequest(url: id)
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(ArtworkCollection.self, from: data)
    }
}
