//
//  ArtworkViewUITests.swift
//  RijksmuseumAHUITests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import XCTest

final class ArtworkViewUITests: XCTestCase {
    func test_fetchArtworkImage_whenLoading_displaysLoadingIndicator() throws {
        // Given
        let useCase = RijksmuseumAHUITestCase.artworkViewLoading
        
        // When
        let app = XCUIApplicationFactory.makeApplication(useCase: useCase)
        app.launch()
        
        // Then
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        let title = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.title.rawValue).firstMatch
        XCTAssertTrue(title.exists)
        
        let loadingView = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.imageLoadingIndicator.rawValue).firstMatch
        XCTAssertTrue(loadingView.exists)
        
        let imageView = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.image.rawValue).firstMatch
        XCTAssertFalse(imageView.exists)
        
        let imageError = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.imageError.rawValue).firstMatch
        XCTAssertFalse(imageError.exists)
    }
    
    func test_fetchArtworkImage_whenResponseIsSuccessful_displaysArtworkImage() throws {
        // Given
        let useCase = RijksmuseumAHUITestCase.artworkViewSuccess
        
        // When
        let app = XCUIApplicationFactory.makeApplication(useCase: useCase)
        app.launch()
        
        // Then
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        let title = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.title.rawValue).firstMatch
        XCTAssertTrue(title.exists)
        
        let loadingView = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.imageLoadingIndicator.rawValue).firstMatch
        XCTAssertFalse(loadingView.exists)
        
        let imageView = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.image.rawValue).firstMatch
        XCTAssertTrue(imageView.exists)
        
        let imageError = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.imageError.rawValue).firstMatch
        XCTAssertFalse(imageError.exists)
    }
    
    func test_fetchArtworkImage_whenResponseFails_displaysErrorMessage() throws {
        // Given
        let useCase = RijksmuseumAHUITestCase.artworkViewFailure
        
        // When
        let app = XCUIApplicationFactory.makeApplication(useCase: useCase)
        app.launch()
        
        // Then
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        let title = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.title.rawValue).firstMatch
        XCTAssertTrue(title.exists)
        
        let loadingView = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.imageLoadingIndicator.rawValue).firstMatch
        XCTAssertFalse(loadingView.exists)
        
        let imageView = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.image.rawValue).firstMatch
        XCTAssertFalse(imageView.exists)
        
        let imageError = app.descendants(matching: .any).matching(identifier: ArtworkViewAccessibilityIdentifier.imageError.rawValue).firstMatch
        XCTAssertTrue(imageError.exists)
    }
}
