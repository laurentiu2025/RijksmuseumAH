//
//  ArtworkShowDetailsServicing.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

protocol ArtworkShowDetailsServicing {
    func fetchShowDetails(id: URL) async throws -> ArtworkShowDetails
}
