//
//  ArtworkDetailsServiceTests.swift
//  RijksmuseumAHTests
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import XCTest
@testable import RijksmuseumAH

final class ArtworkDetailsServiceTests: XCTestCase {
    override func tearDown() {
        NetworkServiceURLProtocol.targetURLs = []
        super.tearDown()
    }
    
    func test_fetchArtworkDetails_whenResponseIsValid_returnsArtworkDetails() async throws  {
        // Given
        let artworkId = URL(string: "https://www.google.com")!
        try configureValidResponse(url: artworkId)
        let sut = artworkDetailsService()
        
        do {
            // When
            let artworkDetails = try await sut.fetchArtworkDetails(id: artworkId)
            
            // Then
            if let artworkIdentifier = artworkDetails.identifiedBy.first {
                XCTAssertEqual(artworkIdentifier.type, .name)
                XCTAssertEqual(artworkIdentifier.content, "Artwork test title")
            } else {
                XCTFail("Missing artwork identifier")
            }
            
            if let artworkShow = artworkDetails.shows.first {
                let expectedArtworkShowId = URL(string: "https://id.rijksmuseum.nl/202322138")!
                XCTAssertEqual(artworkShow.id, expectedArtworkShowId)
                XCTAssertEqual(artworkShow.type, .visualItem)
            } else {
                XCTFail("Missing artwork show")
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_fetchArtworkDetails_whenResponseIsInvalid_throwsError() async throws  {
        // Given
        let artworkId = URL(string: "https://www.google.com")!
        try configureInvalidResponse(url: artworkId)
        let sut = artworkDetailsService()
        
        do {
            // When
            _ = try await sut.fetchArtworkDetails(id: artworkId)
            XCTFail("Expected error to be thrown, but succeeded instead")
        } catch {
            // Then
            XCTAssertTrue(true, "Error was correctly thrown")
        }
    }
    
    // MARK: - Valid response
    
    private func configureValidResponse(url: URL) throws {
        let data = try validArtworkDetailsData()
        let targetURLBehaviour = NetworkServiceTargetURLBehaviour.success(data: data)
        let targetURL = NetworkServiceTargetURL(url: url, behaviour: targetURLBehaviour)
        NetworkServiceURLProtocol.targetURLs = [targetURL]
    }
    
    private func validArtworkDetailsData() throws -> Data {
        let jsonString = """
        {
            "identified_by": [
                {
                    "type": "Name",
                    "content": "Artwork test title"
                }
            ],
            "shows": [
                {
                    "id": "https://id.rijksmuseum.nl/202322138",
                    "type": "VisualItem"
                }
            ]
        }
        """
        
        return try XCTUnwrap(jsonString.data(using: .utf8), "Invalid test data")
    }
    
    // MARK: - Invalid response
    
    private func configureInvalidResponse(url: URL) throws {
        let data = try invalidArtworkDetailsData()
        let targetURLBehaviour = NetworkServiceTargetURLBehaviour.success(data: data)
        let targetURL = NetworkServiceTargetURL(url: url, behaviour: targetURLBehaviour)
        NetworkServiceURLProtocol.targetURLs = [targetURL]
    }
    
    private func invalidArtworkDetailsData() throws -> Data {
        let jsonString = """
        {
            "identified_by_invalid": [
                {
                    "type": "Name",
                    "content": "Artwork test title"
                }
            ],
            "shows_invalid": [
                {
                    "id": "https://id.rijksmuseum.nl/202322138",
                    "type": "VisualItem"
                }
            ]
        }
        """
        
        return try XCTUnwrap(jsonString.data(using: .utf8), "Invalid test data")
    }
    
    // MARK: - Sut
    
    private func artworkDetailsService() -> ArtworkDetailsService {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [NetworkServiceURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        let jsonDecoder = JSONDecoder()
        return ArtworkDetailsService(session: session, decoder: jsonDecoder)
    }
}
