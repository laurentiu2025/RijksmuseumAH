//
//  ArtworkCollectionItemCellVisibility.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import UIKit

struct ArtworkCollectionItemCellVisibility {
    let title: String?
    let isStackViewHidden: Bool
    let isLoadingIndicatorHidden: Bool
    let artworkImageViewBackgroundColor: UIColor
    let artworkImageViewState: ArtworkCollectionItemCellImageViewState
    let errorTitle: String?
    let isErrorTitleHidden: Bool
}
