//
//  ImageDownloading.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

protocol ImageDownloading {
    func downloadImage(url: URL) async throws -> Data
}
