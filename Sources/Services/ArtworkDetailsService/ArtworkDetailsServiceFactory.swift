//
//  ArtworkDetailsServiceFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkDetailsServiceFactory {
    static func makeService() -> ArtworkDetailsService {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        return ArtworkDetailsService(session: session, decoder: decoder)
    }
}
