//
//  ImageDownloader.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class ImageDownloader: ImageDownloading {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - ImageDownloading
    
    func downloadImage(url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        return data
    }
}
