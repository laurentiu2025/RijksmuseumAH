//
//  ArtworkViewModeling.swift
//  RijksmuseumAH
//
//  Created by Laurentiu Cociu on 9/18/25.
//

import Foundation

protocol ArtworkViewModeling {
    var title: String { get }
    var imageState: ArtworkViewImageState { get }
    func fetchArtworkImageData() async
}
