//
//  ArtworkCollectionItemCellVisibilityMapper.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import UIKit

final class ArtworkCollectionItemCellVisibilityMapper {
    static func mapVisibility(loaderState state: ArtworkItemDataLoaderState) -> ArtworkCollectionItemCellVisibility {
        switch state {
        case .idle,
                .loadingTitle:
            return ArtworkCollectionItemCellVisibility(title: nil,
                                                       image: nil,
                                                       isStackViewHidden: true,
                                                       isArtworkLoadingIndicatorHidden: false,
                                                       artworkImageViewBackgroundColor: .clear,
                                                       isImageLoadingIndicatorHidden: true,
                                                       isErrorTitleHidden: true,
                                                       errorTitle: nil)
        case .titleLoaded(let title),
                .loadingContent(let title):
            return ArtworkCollectionItemCellVisibility(title: title,
                                                       image: nil,
                                                       isStackViewHidden: false,
                                                       isArtworkLoadingIndicatorHidden: true,
                                                       artworkImageViewBackgroundColor: .gray,
                                                       isImageLoadingIndicatorHidden: false,
                                                       isErrorTitleHidden: true,
                                                       errorTitle: nil)
        case .contentLoaded(let artworkData),
                .loadingImage(let artworkData):
            return ArtworkCollectionItemCellVisibility(title: artworkData.title,
                                                       image: nil,
                                                       isStackViewHidden: false,
                                                       isArtworkLoadingIndicatorHidden: true,
                                                       artworkImageViewBackgroundColor: .gray,
                                                       isImageLoadingIndicatorHidden: false,
                                                       isErrorTitleHidden: true,
                                                       errorTitle: nil)
        case .loaded(let artworkData, let imageData):
            let image = UIImage(data: imageData)
            return ArtworkCollectionItemCellVisibility(title: artworkData.title,
                                                       image: image,
                                                       isStackViewHidden: false,
                                                       isArtworkLoadingIndicatorHidden: true,
                                                       artworkImageViewBackgroundColor: .gray,
                                                       isImageLoadingIndicatorHidden: true,
                                                       isErrorTitleHidden: true,
                                                       errorTitle: nil)
        case .failed(let error):
            return ArtworkCollectionItemCellVisibility(title: nil,
                                                       image: nil,
                                                       isStackViewHidden: true,
                                                       isArtworkLoadingIndicatorHidden: true,
                                                       artworkImageViewBackgroundColor: .clear,
                                                       isImageLoadingIndicatorHidden: true,
                                                       isErrorTitleHidden: false,
                                                       errorTitle: error.localizedDescription)
        }
    }
}
