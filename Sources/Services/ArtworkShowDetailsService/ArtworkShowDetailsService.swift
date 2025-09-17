//
//  ArtworkShowDetailsService.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkShowDetailsService: ArtworkShowDetailsServicing {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - ArtworkShowDetailsServicing
    
    func fetchShowDetails(id: URL) async throws -> ArtworkShowDetails {
        let request = URLRequest(url: id)
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(ArtworkShowDetails.self, from: data)
    }
}
