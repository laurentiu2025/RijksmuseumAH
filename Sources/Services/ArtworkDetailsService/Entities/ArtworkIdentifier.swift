//
//  ArtworkIdentifier.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

struct ArtworkIdentifier: Decodable {
    let type: ArtworkIdentifierType
    let content: String
}
