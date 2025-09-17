//
//  IIIFImageSize.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

enum IIIFImageSize {
    case max
    case custom(Int)
    
    var rawValue: String {
        switch self {
        case .max:
            return "max"
        case .custom(let size):
            return String(size)
        }
    }
}
