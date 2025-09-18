//
//  ArtworkCollectionItemCellStateMapper.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import UIKit

final class ArtworkCollectionItemCellStateMapper {
    static func mapState(loaderState state: ArtworkItemDataLoaderState) -> ArtworkCollectionItemCellState {
        switch state {
        case .idle,
                .loadingTitle:
            return ArtworkCollectionItemCellState(title: nil,
                                                  image: nil,
                                                  isStackViewHidden: true,
                                                  isArtworkLoadingIndicatorHidden: false,
                                                  isImageBackgroundHidden: true,
                                                  isImageLoadingIndicatorHidden: true,
                                                  errorTitle: nil)
        case .titleLoaded(let title),
                .loadingContent(let title):
            return ArtworkCollectionItemCellState(title: title,
                                                  image: nil,
                                                  isStackViewHidden: false,
                                                  isArtworkLoadingIndicatorHidden: true,
                                                  isImageBackgroundHidden: false,
                                                  isImageLoadingIndicatorHidden: false,
                                                  errorTitle: nil)
        case .contentLoaded(let artworkData),
                .loadingImage(let artworkData):
            return ArtworkCollectionItemCellState(title: artworkData.title,
                                                  image: nil,
                                                  isStackViewHidden: false,
                                                  isArtworkLoadingIndicatorHidden: true,
                                                  isImageBackgroundHidden: false,
                                                  isImageLoadingIndicatorHidden: false,
                                                  errorTitle: nil)
        case .loaded(let artworkData, let imageData):
            let image = UIImage(data: imageData)
            return ArtworkCollectionItemCellState(title: artworkData.title,
                                                  image: image,
                                                  isStackViewHidden: false,
                                                  isArtworkLoadingIndicatorHidden: true,
                                                  isImageBackgroundHidden: false,
                                                  isImageLoadingIndicatorHidden: true,
                                                  errorTitle: nil)
        case .failed(let error):
            return ArtworkCollectionItemCellState(title: nil,
                                                  image: nil,
                                                  isStackViewHidden: true,
                                                  isArtworkLoadingIndicatorHidden: true,
                                                  isImageBackgroundHidden: true,
                                                  isImageLoadingIndicatorHidden: true,
                                                  errorTitle: error.localizedDescription)
        }
    }
}
