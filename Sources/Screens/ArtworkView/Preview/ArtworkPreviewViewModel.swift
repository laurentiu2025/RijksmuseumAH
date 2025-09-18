//
//  ArtworkPreviewViewModel.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import UIKit

@Observable
final class ArtworkPreviewViewModel: ArtworkViewModeling {
    var title: String = "Test title"
    private(set) var imageState: ArtworkViewImageState = .idle
    
    // MARK: - ArtworkViewModeling
    
    @MainActor
    func fetchArtworkImageData() async {
        guard let image = UIImage(systemName: "photo.artframe"),
              let data = image.pngData() else {
            return
        }
        
        imageState = .loaded(.success(data))
    }
}
