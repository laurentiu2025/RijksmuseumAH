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
                .loadingReference:
            return ArtworkCollectionItemCellVisibility(title: nil,
                                                       isStackViewHidden: true,
                                                       isLoadingIndicatorHidden: false,
                                                       artworkImageViewBackgroundColor: .clear,
                                                       artworkImageViewState: .idle,
                                                       errorTitle: nil,
                                                       isErrorTitleHidden: true)
        case .referenceLoaded(let reference),
                .loadingResource(let reference):
            return ArtworkCollectionItemCellVisibility(title: reference.title,
                                                       isStackViewHidden: false,
                                                       isLoadingIndicatorHidden: true,
                                                       artworkImageViewBackgroundColor: .gray,
                                                       artworkImageViewState: .loading,
                                                       errorTitle: nil,
                                                       isErrorTitleHidden: true)
        case .resourceLoaded(let resource),
                .loadingImage(let resource):
            return ArtworkCollectionItemCellVisibility(title: resource.title,
                                                       isStackViewHidden: false,
                                                       isLoadingIndicatorHidden: true,
                                                       artworkImageViewBackgroundColor: .gray,
                                                       artworkImageViewState: .loading,
                                                       errorTitle: nil,
                                                       isErrorTitleHidden: true)
        case .loaded(let resource, let imageResult):
            switch imageResult {
            case .success(let imageData):
                return ArtworkCollectionItemCellVisibility(title: resource.title,
                                                           isStackViewHidden: false,
                                                           isLoadingIndicatorHidden: true,
                                                           artworkImageViewBackgroundColor: .gray,
                                                           artworkImageViewState: .success(imageData: imageData),
                                                           errorTitle: nil,
                                                           isErrorTitleHidden: true)
            case .failure(let error):
                return ArtworkCollectionItemCellVisibility(title: resource.title,
                                                           isStackViewHidden: false,
                                                           isLoadingIndicatorHidden: true,
                                                           artworkImageViewBackgroundColor: .gray,
                                                           artworkImageViewState: .failure(error: error),
                                                           errorTitle: nil,
                                                           isErrorTitleHidden: true)
            }
        case .failed(let error):
            switch error {
            case .loadReferenceFailed(let error):
                return ArtworkCollectionItemCellVisibility(title: nil,
                                                           isStackViewHidden: true,
                                                           isLoadingIndicatorHidden: true,
                                                           artworkImageViewBackgroundColor: .clear,
                                                           artworkImageViewState: .idle,
                                                           errorTitle: error.localizedDescription,
                                                           isErrorTitleHidden: false)
            case .loadResourceFailed(let reference, let error):
                return ArtworkCollectionItemCellVisibility(title: reference.title,
                                                           isStackViewHidden: false,
                                                           isLoadingIndicatorHidden: true,
                                                           artworkImageViewBackgroundColor: .gray,
                                                           artworkImageViewState: .failure(error: error),
                                                           errorTitle: nil,
                                                           isErrorTitleHidden: true)
            }
        }
    }
}
