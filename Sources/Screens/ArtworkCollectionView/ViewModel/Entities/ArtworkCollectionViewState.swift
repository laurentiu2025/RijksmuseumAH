//
//  ArtworkCollectionViewState.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

enum ArtworkCollectionViewState {
    case idle
    case loadingInitial
    case initialLoadFailed(Error)
    case loaded(items: [ArtworkCollectionItemCellModel], next: ArtworkNextCollection)
    case loadingMore(items: [ArtworkCollectionItemCellModel], next: ArtworkNextCollection)
    case loadMoreFailed(items: [ArtworkCollectionItemCellModel], next: ArtworkNextCollection, error: Error)
}
