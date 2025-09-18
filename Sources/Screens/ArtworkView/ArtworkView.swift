//
//  ArtworkView.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import SwiftUI

struct ArtworkView: View {
    var viewModel: ArtworkViewModeling
    
    init(viewModel: ArtworkViewModeling) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                titleView()
                contentView()
            }
            .padding()
        }
        .task {
            await viewModel.fetchArtworkImageData()
        }
    }
    
    @ViewBuilder
    private func titleView() -> some View {
        Text(viewModel.title)
            .multilineTextAlignment(.leading)
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        GeometryReader { geometry in
            let imageWidth = geometry.size.width
            let imageHeight = imageWidth
            
            ZStack {
                Color.gray.opacity(0.2)
                    .frame(width: imageWidth, height: imageHeight)
                    .cornerRadius(8)
                let size = CGSize(width: imageWidth, height: imageHeight)
                imageView(size: size)
            }
            .frame(width: geometry.size.width, height: imageHeight, alignment: .center)
        }
    }
    
    @ViewBuilder
    private func imageView(size: CGSize) -> some View {
        switch viewModel.imageState {
        case .idle, .loading:
            imageLoadingView()
        case .loaded(let result):
            imageLoadedView(result: result, size: size)
        }
    }
    
    @ViewBuilder
    private func imageLoadingView() -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
    }
    
    @ViewBuilder
    private func imageLoadedView(result: ArtworkViewImageState.ImageLoadedResult, size: CGSize) -> some View {
        switch result {
        case .success(let imageData):
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(10)
            } else {
                errorView(message: "Invalid image")
            }
        case .failure(let error):
            errorView(message: error.localizedDescription)
        }
    }
    
    @ViewBuilder
    private func errorView(message: String) -> some View {
        Text(message)
            .font(.title)
            .foregroundStyle(.red)
    }
}

#Preview {
    let viewModel = ArtworkPreviewViewModel()
    return ArtworkView(viewModel: viewModel)
}
