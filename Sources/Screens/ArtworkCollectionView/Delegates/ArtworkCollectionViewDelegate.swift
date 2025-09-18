//
//  ArtworkCollectionViewDelegate.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import UIKit

class ArtworkCollectionViewDelegate: NSObject, UICollectionViewDelegate, UIScrollViewDelegate {
    var artworkItems = [ArtworkCollectionItemCellModeling]()
    
    typealias IndexPathSelectionHandler = (IndexPath) -> Void
    var onIndexPathSelected: IndexPathSelectionHandler?
    
    typealias ScrollToBottomHandler = () -> Void
    var onScrolledToBottom: ScrollToBottomHandler?
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onIndexPathSelected?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let artworkCollectionItemCell = cell as? ArtworkCollectionItemCell else {
            return
        }
        
        let artworkItemViewModel = artworkItems[indexPath.row]
        artworkItemViewModel.onStateUpdate = { state in
            guard let visibleArtworkCollectionItemCell = collectionView.cellForItem(at: indexPath) as? ArtworkCollectionItemCell else {
                return
            }
            
            visibleArtworkCollectionItemCell.show(state: state)
        }
        
        artworkCollectionItemCell.show(state: artworkItemViewModel.state)
        artworkItemViewModel.loadIfNeeded()
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let contentOffsetY = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let bottomEdgePosition = contentOffsetY + scrollViewHeight
        let isNearBottom = bottomEdgePosition >= totalContentHeight
        guard isNearBottom else {
            return
        }
        
        onScrolledToBottom?()
    }
}
