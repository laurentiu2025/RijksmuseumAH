//
//  IIIFImageDownloading.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

protocol IIIFImageDownloading {
    func downloadImage(id: String, with info: IIIFImageInfo) async throws -> Data
}
