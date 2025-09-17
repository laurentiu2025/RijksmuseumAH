//
//  ArtworkVisualItemIdentifier.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

struct ArtworkVisualItemIdentifier: Decodable {
    let id: URL
    let type: ArtworkVisualItemIdentifierType
}
