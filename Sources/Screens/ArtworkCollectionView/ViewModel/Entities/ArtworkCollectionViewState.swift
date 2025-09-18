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
    case loaded(items: [ArtworkCollectionItemCellModeling], next: ArtworkNextCollection)
    case loadingMore(items: [ArtworkCollectionItemCellModeling], next: ArtworkNextCollection)
    case loadMoreFailed(items: [ArtworkCollectionItemCellModeling], next: ArtworkNextCollection, error: Error)
}
