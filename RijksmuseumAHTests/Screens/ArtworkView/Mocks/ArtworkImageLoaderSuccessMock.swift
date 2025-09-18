//
//  ArtworkImageLoaderSuccessMock.swift
//  RijksmuseumAHTests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import XCTest
@testable import RijksmuseumAH

final class ArtworkImageLoaderSuccessMock: ArtworkImageLoading {
    
    // MARK: - ArtworkImageLoading
    
    func loadImage(imageID: String) async throws -> Data {
        return Data([0x00, 0x01, 0x02])
    }
}
