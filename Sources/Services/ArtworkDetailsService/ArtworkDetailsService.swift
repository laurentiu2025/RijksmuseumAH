//
//  ArtworkDetailsService.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkDetailsService: ArtworkDetailsServicing {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - ArtworkDetailsServicing
    
    func fetchArtworkDetails(id: URL) async throws -> ArtworkDetails {
        let request = URLRequest(url: id)
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(ArtworkDetails.self, from: data)
    }
} 
