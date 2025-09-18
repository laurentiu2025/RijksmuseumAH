//
//  ArtworkCollectionItemCellImageViewVisibilityMapper.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import UIKit

final class ArtworkCollectionItemCellImageViewVisibilityMapper {
    static func mapVisibility(state: ArtworkCollectionItemCellImageViewState) -> ArtworkCollectionItemCellImageViewVisibility {
        switch state {
        case .idle:
            return ArtworkCollectionItemCellImageViewVisibility(image: nil,
                                                                isImageViewHidden: true,
                                                                isLoadingIndicatorHidden: true,
                                                                errorTitle: nil,
                                                                isErrorViewHidden: true)
        case .loading:
            return ArtworkCollectionItemCellImageViewVisibility(image: nil,
                                                                isImageViewHidden: true,
                                                                isLoadingIndicatorHidden: false,
                                                                errorTitle: nil,
                                                                isErrorViewHidden: true)
        case .success(let imageData):
            let image = UIImage(data: imageData)
            return ArtworkCollectionItemCellImageViewVisibility(image: image,
                                                                isImageViewHidden: false,
                                                                isLoadingIndicatorHidden: true,
                                                                errorTitle: nil,
                                                                isErrorViewHidden: true)
        case .failure(let error):
            return ArtworkCollectionItemCellImageViewVisibility(image: nil,
                                                                isImageViewHidden: true,
                                                                isLoadingIndicatorHidden: true,
                                                                errorTitle: error.localizedDescription,
                                                                isErrorViewHidden: false)
        }
    }
}
