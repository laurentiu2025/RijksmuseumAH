//
//  ArtworkDigitalItemServiceFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ArtworkDigitalItemServiceFactory {
    static func makeService() -> ArtworkDigitalItemService {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        return ArtworkDigitalItemService(session: session, decoder: decoder)
    }
}
