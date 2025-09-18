//
//  IIIFImageURLBuilder.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class DefaultIIIFImageURLBuilder: IIIFImageURLBuilding {
    private struct API {
        static let base = URL(string: "https://iiif.micr.io")!
    }
    
    // MARK: - IIIFImageURLBuilding
    
    func buildURL(imageID: String, info: IIIFImageInfo) -> URL {
        let imageURL = API.base.appendingPathComponent(imageID)
        let regionURL = imageURL.appendingPathComponent(info.region.rawValue)
        let sizeURL = regionURL.appendingPathComponent(info.size.rawValue)
        let rotationURL = sizeURL.appendingPathComponent(String(info.rotation))
        let filename = [info.quality.rawValue, info.format.rawValue].joined(separator: ".")
        return rotationURL.appendingPathComponent(filename)
    }
}
