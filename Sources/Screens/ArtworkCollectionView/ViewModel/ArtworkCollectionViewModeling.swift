//
//  ArtworkCollectionViewModeling.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

protocol ArtworkCollectionViewModeling {
    typealias OnStateChangeHandler = (ArtworkCollectionViewState) -> Void
    var onStateChange: OnStateChangeHandler? { get set }
    func fetchArtworkItems()
    func fetchMoreArtworkItems()
}
