//
//  ArtworkVisualItemServiceFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkVisualItemServiceFactory {
    static func makeService() -> ArtworkVisualItemService {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        return ArtworkVisualItemService(session: session, decoder: decoder)
    }
}
