//
//  ImageDownloaderFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ImageDownloaderFactory {
    static func makeDownloader() -> ImageDownloader {
        let session = URLSession.shared
        return ImageDownloader(session: session)
    }
}
