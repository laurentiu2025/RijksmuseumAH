//
//  ArtworkCollectionItemCellImageViewState.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

enum ArtworkCollectionItemCellImageViewState {
    case idle
    case loading
    case success(imageData: Data)
    case failure(error: Error)
}
