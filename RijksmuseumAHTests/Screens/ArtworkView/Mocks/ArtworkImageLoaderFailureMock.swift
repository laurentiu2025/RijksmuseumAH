//
//  ArtworkImageLoaderFailureMock.swift
//  RijksmuseumAHTests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import XCTest
@testable import RijksmuseumAH

final class ArtworkImageLoaderFailureMock: ArtworkImageLoading {
    enum MockError: Error {
        case failed
    }
    
    // MARK: - ArtworkImageLoading
    
    func loadImage(imageID: String) async throws -> Data {
        throw MockError.failed
    }
}
