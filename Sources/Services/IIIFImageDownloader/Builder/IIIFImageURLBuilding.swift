//
//  IIIFImageURLBuilding.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

protocol IIIFImageURLBuilding {
    func buildURL(imageId: String, info: IIIFImageInfo) -> URL
}
