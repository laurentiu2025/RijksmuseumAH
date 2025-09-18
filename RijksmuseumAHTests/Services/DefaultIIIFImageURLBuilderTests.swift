//
//  DefaultIIIFImageURLBuilderTests.swift
//  RijksmuseumAHTests
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import XCTest
@testable import RijksmuseumAH

final class DefaultIIIFImageURLBuilderTests: XCTestCase {
    func test_buildURL_whenSizeIsMax_returnsMaxSizeURL() async throws  {
        // Given
        let imageID = "1234"
        let info = IIIFImageInfo(region: .full, size: .max, rotation: 0, quality: .standard, format: .jpg)
        let sut = DefaultIIIFImageURLBuilder()
        
        // When
        let url = sut.buildURL(imageID: imageID, info: info)
        
        // Then
        let expectedURL = URL(string: "https://iiif.micr.io/1234/full/max/0/default.jpg")
        XCTAssertEqual(url, expectedURL)
    }
    
    func test_buildURL_whenSizeIsCustom_returnsCustomSizeURL() async throws  {
        // Given
        let imageID = "1234"
        let info = IIIFImageInfo(region: .full, size: .custom(100), rotation: 0, quality: .standard, format: .jpg)
        let sut = DefaultIIIFImageURLBuilder()
        
        // When
        let url = sut.buildURL(imageID: imageID, info: info)
        
        // Then
        let expectedURL = URL(string: "https://iiif.micr.io/1234/full/100/0/default.jpg")
        XCTAssertEqual(url, expectedURL)
    }
    
    func test_buildURL_whenFormatIsJPG_returnsJPGUrl() async throws  {
        // Given
        let imageID = "1234"
        let info = IIIFImageInfo(region: .full, size: .max, rotation: 0, quality: .standard, format: .jpg)
        let sut = DefaultIIIFImageURLBuilder()
        
        // When
        let url = sut.buildURL(imageID: imageID, info: info)
        
        // Then
        let expectedURL = URL(string: "https://iiif.micr.io/1234/full/max/0/default.jpg")
        XCTAssertEqual(url, expectedURL)
    }
    
    func test_buildURL_whenFormatIsPNG_returnsPNGUrl() async throws  {
        // Given
        let imageID = "1234"
        let info = IIIFImageInfo(region: .full, size: .max, rotation: 0, quality: .standard, format: .png)
        let sut = DefaultIIIFImageURLBuilder()
        
        // When
        let url = sut.buildURL(imageID: imageID, info: info)
        
        // Then
        let expectedURL = URL(string: "https://iiif.micr.io/1234/full/max/0/default.png")
        XCTAssertEqual(url, expectedURL)
    }
}
