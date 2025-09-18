//
//  ArtworkViewFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

final class ArtworkViewFactory {
    static func makeView(artworkResource: ArtworkResource) -> ArtworkView {
        let viewModel = ArtworkViewModelFactory.makeModel(artworkResource: artworkResource)
        return ArtworkView(viewModel: viewModel)
    }
}
