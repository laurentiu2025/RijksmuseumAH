//
//  ArtworkCollectionServiceTests.swift
//  RijksmuseumAHTests
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import XCTest
@testable import RijksmuseumAH

final class ArtworkCollectionServiceTests: XCTestCase {
    override func tearDown() {
        NetworkServiceURLProtocol.targetURLs = []
        super.tearDown()
    }
    
    func test_fetchArtworkCollection_whenResponseIsValid_returnsArtworkCollection() async throws  {
        // Given
        try configureValidResponse()
        let sut = artworkCollectionService()
        
        do {
            // When
            let artworkCollection = try await sut.fetchArtworkCollection()
            
            // Then
            XCTAssertEqual(artworkCollection.next.id.absoluteString, "https://example.com/next-page")
            XCTAssertEqual(artworkCollection.next.type, .orderedCollectionPage)
            
            if let artworkItem = artworkCollection.items.first {
                XCTAssertEqual(artworkItem.id.absoluteString, "https://id.rijksmuseum.nl/200322097")
                XCTAssertEqual(artworkItem.type, .humanMadeObject)
            } else {
                XCTFail("Missing artwork item")
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_fetchArtworkCollection_whenResponseIsInvalid_throwsError() async throws  {
        // Given
        try configureInvalidResponse()
        let sut = artworkCollectionService()
        
        do {
            // When
            _ = try await sut.fetchArtworkCollection()
            XCTFail("Expected error to be thrown, but succeeded instead")
        } catch {
            // Then
            XCTAssertTrue(true, "Error was correctly thrown")
        }
    }
    
    // MARK: - Valid response
    
    private func configureValidResponse() throws {
        let url = ArtworkCollectionService.API.base
        let data = try validArtworkData()
        let targetURLBehaviour = NetworkServiceTargetURLBehaviour.success(data: data)
        let targetURL = NetworkServiceTargetURL(url: url, behaviour: targetURLBehaviour)
        NetworkServiceURLProtocol.targetURLs = [targetURL]
    }
    
    private func validArtworkData() throws -> Data {
        let jsonString = """
        {
            "next": {
                "id": "https://example.com/next-page",
                "type": "OrderedCollectionPage"
            },
            "orderedItems": [
                {
                    "id": "https://id.rijksmuseum.nl/200322097",
                    "type": "HumanMadeObject"
                }
            ]
        }
        """
        
        return try XCTUnwrap(jsonString.data(using: .utf8), "Invalid test data")
    }
    
    // MARK: - Invalid response
    
    private func configureInvalidResponse() throws {
        let url = ArtworkCollectionService.API.base
        let data = try invalidArtworkData()
        let targetURLBehaviour = NetworkServiceTargetURLBehaviour.success(data: data)
        let targetURL = NetworkServiceTargetURL(url: url, behaviour: targetURLBehaviour)
        NetworkServiceURLProtocol.targetURLs = [targetURL]
    }
    
    private func invalidArtworkData() throws -> Data {
        let jsonString = """
        {
            "next_invalid": {
                "id": "https://example.com/next-page",
                "type": "OrderedCollectionPage"
            },
            "orderedItems_invalid": [
                {
                    "id": "https://id.rijksmuseum.nl/200322097",
                    "type": "HumanMadeObject"
                }
            ]
        }
        """
        
        return try XCTUnwrap(jsonString.data(using: .utf8), "Invalid test data")
    }
    
    // MARK: - Sut
    
    private func artworkCollectionService() -> ArtworkCollectionService {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [NetworkServiceURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        let jsonDecoder = JSONDecoder()
        return ArtworkCollectionService(session: session, decoder: jsonDecoder)
    }
}
