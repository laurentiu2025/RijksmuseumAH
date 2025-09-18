//
//  ArtworkCollectionItemCellModeling.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

protocol ArtworkCollectionItemCellModeling: AnyObject {
    var state: ArtworkItemDataLoaderState { get }
    typealias StateUpdateHandler = (ArtworkItemDataLoaderState) -> Void
    var onStateUpdate: StateUpdateHandler? { get set }
    func loadIfNeeded()
}
