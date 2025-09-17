//
//  ArtworkDigitalItemServicing.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

protocol ArtworkDigitalItemServicing {
    func fetchDigitalItem(id: URL) async throws -> ArtworkDigitalItem
}
