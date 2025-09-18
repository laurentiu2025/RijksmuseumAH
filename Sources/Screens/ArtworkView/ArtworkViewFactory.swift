//
//  ArtworkViewFactory.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

final class ArtworkViewFactory {
    static func makeView(artworkResource: ArtworkResource) -> ArtworkView {
#if DEBUG
        if let testUseCase = TestEnvironmentBuilder.readTestCase() {
            return makeTestView(useCase: testUseCase, artworkResource: artworkResource)
        } else {
            return makeProductionView(artworkResource: artworkResource)
        }
#else
        return makeProductionView(artworkResource: artworkResource)
#endif
    }
    
    static func makeProductionView(artworkResource: ArtworkResource) -> ArtworkView {
        let viewModel = ArtworkViewModelFactory.makeModel(artworkResource: artworkResource)
        return ArtworkView(viewModel: viewModel)
    }
    
#if DEBUG
    static func makeTestView(useCase: RijksmuseumAHUITestCase, artworkResource: ArtworkResource) -> ArtworkView {
        let viewModel = ArtworkViewModelMock(useCase: useCase)
        return ArtworkView(viewModel: viewModel)
    }
#endif
}
