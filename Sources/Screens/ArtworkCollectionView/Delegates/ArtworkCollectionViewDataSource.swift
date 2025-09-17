//
//  ArtworkCollectionViewDataSource.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import UIKit

class ArtworkCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var artworkItems = [ArtworkCollectionItemCellModeling]()
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artworkItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let artworkCollectionItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtworkCollectionItemCell.identifier, for: indexPath) as! ArtworkCollectionItemCell
        let artworkItemViewModel = artworkItems[indexPath.item]
        artworkCollectionItemCell.show(artworkId: artworkItemViewModel.artworkId)
        return artworkCollectionItemCell
    }
}
