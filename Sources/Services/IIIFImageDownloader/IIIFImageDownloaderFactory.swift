//
//  IIIFImageDownloaderFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class IIIFImageDownloaderFactory {
    static func makeDownloader() -> IIIFImageDownloader {
        let imageDownloader = ImageDownloaderFactory.makeDownloader()
        let urlBuilder = DefaultIIIFImageURLBuilder()
        return IIIFImageDownloader(imageDownloader: imageDownloader, urlBuilder: urlBuilder)
    }
}
