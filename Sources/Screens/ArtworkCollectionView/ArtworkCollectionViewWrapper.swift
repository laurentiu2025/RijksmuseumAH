//
//  ArtworkCollectionViewWrapper.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import SwiftUI

struct ArtworkCollectionViewWrapper: UIViewControllerRepresentable {
    typealias ArtworkSelectionHandler = (_ artworkId: URL) -> Void
    var onArtworkSelected: ArtworkSelectionHandler?
    
    // MARK: - UIViewControllerRepresentable
    
    typealias UIViewControllerType = ArtworkCollectionViewController
    
    func makeUIViewController(context: Context) -> ArtworkCollectionViewController {
        let controller = ArtworkCollectionViewControllerFactory.makeController()
        controller.onArtworkSelected = onArtworkSelected
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ArtworkCollectionViewController, context: Context) {
        uiViewController.onArtworkSelected = onArtworkSelected
    }
}
