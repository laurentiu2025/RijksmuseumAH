//
//  ArtworkVisualItem.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

struct ArtworkVisualItem: Decodable {
    let digitallyShownBy: [ArtworkVisualItemIdentifier]
    
    private enum CodingKeys: String, CodingKey {
        case digitallyShownBy = "digitally_shown_by"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let digitallyShownBy = try container.decode([FailableDecodable<ArtworkVisualItemIdentifier>].self, forKey: .digitallyShownBy)
        self.digitallyShownBy = digitallyShownBy.compactMap { $0.value }
    }
}
