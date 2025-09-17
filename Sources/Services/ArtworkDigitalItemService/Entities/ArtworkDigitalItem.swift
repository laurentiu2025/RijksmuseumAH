//
//  ArtworkDigitalItem.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

struct ArtworkDigitalItem: Decodable {
    let accessPoint: [ArtworkDigitalItemAccessPoint]
    
    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let accessPoint = try container.decode([FailableDecodable<ArtworkDigitalItemAccessPoint>].self, forKey: .accessPoint)
        self.accessPoint = accessPoint.compactMap { $0.value }
    }
}
