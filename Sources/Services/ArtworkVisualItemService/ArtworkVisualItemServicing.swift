//
//  ArtworkVisualItemServicing.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

protocol ArtworkVisualItemServicing {
    func fetchVisualItem(id: URL) async throws -> ArtworkVisualItem
}
