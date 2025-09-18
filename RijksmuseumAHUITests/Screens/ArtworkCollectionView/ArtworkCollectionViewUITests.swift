//
//  ArtworkCollectionViewUITests.swift
//  RijksmuseumAHUITests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import XCTest

final class ArtworkCollectionViewUITests: XCTestCase {
    func test_fetchArtworkCollection_whenLoading_displaysLoadingIndicator() throws {
        // Given
        let useCase = RijksmuseumAHUITestCase.artworkCollectionViewLoading
        
        // When
        let app = XCUIApplicationFactory.makeApplication(useCase: useCase)
        app.launch()
        
        // Then
        let loadingView = app.descendants(matching: .any).matching(identifier: ArtworkCollectionViewAccessibilityIdentifier.loadingIndicator.rawValue).firstMatch
        XCTAssertTrue(loadingView.exists)
        
        let collectionView = app.descendants(matching: .any).matching(identifier: ArtworkCollectionViewAccessibilityIdentifier.collectionView.rawValue).firstMatch
        XCTAssertFalse(collectionView.exists)
        
        let errorView = app.descendants(matching: .any).matching(identifier: ArtworkCollectionViewAccessibilityIdentifier.errorView.rawValue).firstMatch
        XCTAssertFalse(errorView.exists)
    }
    
    func test_fetchArtworkCollection_whenResponseIsSuccessful_displaysArtworkItems() throws {
        // Given
        let useCase = RijksmuseumAHUITestCase.artworkCollectionViewSuccess
        
        // When
        let app = XCUIApplicationFactory.makeApplication(useCase: useCase)
        app.launch()
        
        // Then
        let loadingView = app.descendants(matching: .any).matching(identifier: ArtworkCollectionViewAccessibilityIdentifier.loadingIndicator.rawValue).firstMatch
        XCTAssertFalse(loadingView.exists)
        
        let collectionView = app.descendants(matching: .any).matching(identifier: ArtworkCollectionViewAccessibilityIdentifier.collectionView.rawValue).firstMatch
        XCTAssertTrue(collectionView.exists)
        
        let errorView = app.descendants(matching: .any).matching(identifier: ArtworkCollectionViewAccessibilityIdentifier.errorView.rawValue).firstMatch
        XCTAssertFalse(errorView.exists)
    }
    
    func test_fetchArtworkCollection_whenResponseFails_displaysErrorMessage() throws {
        // Given
        let useCase = RijksmuseumAHUITestCase.artworkCollectionViewFailure
        
        // When
        let app = XCUIApplicationFactory.makeApplication(useCase: useCase)
        app.launch()
        
        // Then
        let loadingView = app.descendants(matching: .any).matching(identifier: ArtworkCollectionViewAccessibilityIdentifier.loadingIndicator.rawValue).firstMatch
        XCTAssertFalse(loadingView.exists)
        
        let collectionView = app.descendants(matching: .any).matching(identifier: ArtworkCollectionViewAccessibilityIdentifier.collectionView.rawValue).firstMatch
        XCTAssertFalse(collectionView.exists)
        
        let errorView = app.descendants(matching: .any).matching(identifier: ArtworkCollectionViewAccessibilityIdentifier.errorView.rawValue).firstMatch
        XCTAssertTrue(errorView.exists)
    }
}
