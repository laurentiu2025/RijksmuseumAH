//
//  IIIFImageDownloader.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class IIIFImageDownloader: IIIFImageDownloading {
    private let imageDownloader: ImageDownloading
    private let urlBuilder: IIIFImageURLBuilding
    
    init(imageDownloader: ImageDownloading, urlBuilder: IIIFImageURLBuilding) {
        self.imageDownloader = imageDownloader
        self.urlBuilder = urlBuilder
    }
    
    // MARK: - IIIFImageDownloading
    
    func downloadImage(id: String, with info: IIIFImageInfo) async throws -> Data {
        let imageURL = urlBuilder.buildURL(imageId: id, info: info)
        return try await imageDownloader.downloadImage(url: imageURL)
    }
}
