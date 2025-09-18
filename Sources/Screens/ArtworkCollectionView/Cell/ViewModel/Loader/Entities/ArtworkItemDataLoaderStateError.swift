//
//  ArtworkItemDataLoaderStateError.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

enum ArtworkItemDataLoaderStateError {
    case loadReferenceFailed(error: Error)
    case loadResourceFailed(reference: ArtworkReference, error: Error)
}
