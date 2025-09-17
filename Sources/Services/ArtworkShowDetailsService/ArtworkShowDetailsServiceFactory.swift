//
//  ArtworkShowDetailsServiceFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkShowDetailsServiceFactory {
    static func makeService() -> ArtworkShowDetailsService {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        return ArtworkShowDetailsService(session: session, decoder: decoder)
    }
}
