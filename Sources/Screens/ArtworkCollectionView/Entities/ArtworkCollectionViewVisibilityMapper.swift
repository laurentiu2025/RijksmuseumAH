//
//  ArtworkCollectionViewVisibilityMapper.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

final class ArtworkCollectionViewVisibilityMapper {
    static func mapVisibility(state: ArtworkCollectionViewState) -> ArtworkCollectionViewVisibility {
        switch state {
        case .idle,
                .loadingInitial:
            return ArtworkCollectionViewVisibility(isCollectionViewHidden: true,
                                                   items: [],
                                                   isLoadingIndicatorHidden: false,
                                                   isEmptyLabelHidden: true,
                                                   isErrorViewHidden: true,
                                                   errorTitle: nil)
        case .initialLoadFailed(let error):
            return ArtworkCollectionViewVisibility(isCollectionViewHidden: true,
                                                   items: [],
                                                   isLoadingIndicatorHidden: true,
                                                   isEmptyLabelHidden: true,
                                                   isErrorViewHidden: false,
                                                   errorTitle: error.localizedDescription)
        case .loaded(let items, _),
                .loadingMore(let items, _):
            return ArtworkCollectionViewVisibility(isCollectionViewHidden: false,
                                                   items: items,
                                                   isLoadingIndicatorHidden: true,
                                                   isEmptyLabelHidden: !items.isEmpty,
                                                   isErrorViewHidden: true,
                                                   errorTitle: nil)
        case .loadMoreFailed(let items, _, let error):
            // TODO: Consider handling in UI or analytics
            print(error.localizedDescription)
            return ArtworkCollectionViewVisibility(isCollectionViewHidden: false,
                                                   items: items,
                                                   isLoadingIndicatorHidden: true,
                                                   isEmptyLabelHidden: true,
                                                   isErrorViewHidden: true,
                                                   errorTitle: nil)
        }
    }
}
