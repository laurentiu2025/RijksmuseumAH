//
//  ArtworkVisualItemService.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkVisualItemService: ArtworkVisualItemServicing {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - ArtworkVisualItemServicing
    
    func fetchVisualItem(id: URL) async throws -> ArtworkVisualItem {
        let request = URLRequest(url: id)
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(ArtworkVisualItem.self, from: data)
    }
}
