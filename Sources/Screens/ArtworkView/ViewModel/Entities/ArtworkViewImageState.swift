//
//  ArtworkViewImageState.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

enum ArtworkViewImageState {
    case idle
    case loading
    typealias ImageLoadedResult = Result<Data, Error>
    case loaded(ImageLoadedResult)
}
