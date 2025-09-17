//
//  ArtworkDetails.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

struct ArtworkDetails: Decodable {
    let identifiedBy: [ArtworkIdentifier]
    let shows: [ArtworkShow]
    
    private enum CodingKeys: String, CodingKey {
        case identifiedBy = "identified_by"
        case shows
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let identifiedBy = try container.decode([FailableDecodable<ArtworkIdentifier>].self, forKey: .identifiedBy)
        self.identifiedBy = identifiedBy.compactMap { $0.value }
        
        let shows = try container.decode([FailableDecodable<ArtworkShow>].self, forKey: .shows)
        self.shows = shows.compactMap { $0.value }
    }
}
