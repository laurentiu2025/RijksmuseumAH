//
//  ArtworkCollection.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

struct ArtworkCollection: Decodable {
    let next: ArtworkNextCollection
    let items: [ArtworkItem]
    
    private enum CodingKeys: String, CodingKey {
        case next
        case items = "orderedItems"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.next = try container.decode(ArtworkNextCollection.self, forKey: .next)
        
        let items = try container.decode([FailableDecodable<ArtworkItem>].self, forKey: .items)
        self.items = items.compactMap { $0.value }
    }
}
