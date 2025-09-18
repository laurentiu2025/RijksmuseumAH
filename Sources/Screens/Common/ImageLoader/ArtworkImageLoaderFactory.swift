//
//  ArtworkImageLoaderFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

final class ArtworkImageLoaderFactory {
    static func makeThumbnailLoader() -> ArtworkImageLoader {
        let info = IIIFImageInfo(region: .full, size: .custom(150), rotation: 0, quality: .standard, format: .jpg)
        let imageDownloader = IIIFImageDownloaderFactory.makeDownloader()
        return ArtworkImageLoader(info: info, imageDownloader: imageDownloader)
    }
    
    static func makeDetailLoader() -> ArtworkImageLoader {
        let info = IIIFImageInfo(region: .full, size: .max, rotation: 0, quality: .standard, format: .png)
        let imageDownloader = IIIFImageDownloaderFactory.makeDownloader()
        return ArtworkImageLoader(info: info, imageDownloader: imageDownloader)
    }
}
