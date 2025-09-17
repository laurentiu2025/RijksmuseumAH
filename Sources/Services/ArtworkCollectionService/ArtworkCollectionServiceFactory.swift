//
//  ArtworkCollectionServiceFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkCollectionServiceFactory {
    static func makeService() -> ArtworkCollectionService {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        return ArtworkCollectionService(session: session, decoder: decoder)
    }
}
