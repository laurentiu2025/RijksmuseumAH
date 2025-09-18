//
//  ArtworkImageLoader.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

class ArtworkImageLoader: ArtworkImageLoading {
    private let info: IIIFImageInfo
    private let imageDownloader: IIIFImageDownloading
    
    init(info: IIIFImageInfo, imageDownloader: IIIFImageDownloading) {
        self.info = info
        self.imageDownloader = imageDownloader
    }
    
    // MARK: - ArtworkImageLoading
    
    func loadImage(imageId: String) async throws -> Data {
        return try await imageDownloader.downloadImage(id: imageId, with: info)
    }
}
