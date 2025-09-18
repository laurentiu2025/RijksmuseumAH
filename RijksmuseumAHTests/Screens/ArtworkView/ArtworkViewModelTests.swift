//
//  ArtworkViewModelTests.swift
//  RijksmuseumAHTests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import XCTest
@testable import RijksmuseumAH

final class ArtworkViewModelTests: XCTestCase {
    private let artworkResource = ArtworkResource(title: "Test Artwork", imageID: "123")
    
    func testFetchArtworkImageData_InitialState_IsIdle() async {
        // Given
        let imageDownloader = ArtworkImageLoaderSuccessMock()
        let sut = ArtworkViewModel(artworkResource: artworkResource, imageDownloader: imageDownloader)
        
        // When
        let imageState = sut.imageState
        
        // Then
        switch imageState {
        case .idle:
            // ✅ Success
            break
        default:
            XCTFail("Expected imageState to be .idle, but got \(imageState)")
        }
    }
    
    func testFetchArtworkImageData_SuccessfulLoad_UpdatesImageStateToSuccess() async {
        // Given
        let imageDownloader = ArtworkImageLoaderSuccessMock()
        let sut = ArtworkViewModel(artworkResource: artworkResource, imageDownloader: imageDownloader)
        
        // When
        await sut.fetchArtworkImageData()
        
        // Then
        if case let .loaded(result) = sut.imageState {
            switch result {
            case .success(let data):
                let expectedData = Data([0x00, 0x01, 0x02])
                XCTAssertEqual(data, expectedData)
            case .failure:
                XCTFail("Expected success, but got failure")
            }
        } else {
            XCTFail("Expected imageState to be .loaded")
        }
    }
    
    func testFetchArtworkImageData_FailedLoad_UpdatesImageStateToFailure() async {
        // Given
        let imageDownloader = ArtworkImageLoaderFailureMock()
        let sut = ArtworkViewModel(artworkResource: artworkResource, imageDownloader: imageDownloader)
        
        // When
        await sut.fetchArtworkImageData()
        
        // Then
        if case let .loaded(result) = sut.imageState {
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        } else {
            XCTFail("Expected imageState to be .loaded")
        }
    }
}
