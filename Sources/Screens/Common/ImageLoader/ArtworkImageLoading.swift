//
//  ArtworkImageLoading.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

protocol ArtworkImageLoading {
    func loadImage(imageID: String) async throws -> Data
}
