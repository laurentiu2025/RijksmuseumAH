//
//  ArtworkCollectionViewVisibility.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

struct ArtworkCollectionViewVisibility {
    let isCollectionViewHidden: Bool
    let items: [ArtworkCollectionItemCellModeling]
    let isLoadingIndicatorHidden: Bool
    let isEmptyLabelHidden: Bool
    let isErrorViewHidden: Bool
    let errorTitle: String?
}
