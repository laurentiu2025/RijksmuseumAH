//
//  ArtworkDigitalItemService.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkDigitalItemService: ArtworkDigitalItemServicing {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - ArtworkDigitalItemServicing
    
    func fetchDigitalItem(id: URL) async throws -> ArtworkDigitalItem {
        let request = URLRequest(url: id)
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(ArtworkDigitalItem.self, from: data)
    }
}
