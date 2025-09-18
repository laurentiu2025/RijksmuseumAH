//
//  ArtworkImageDataGenerator.swift
//  RijksmuseumAHUITests
//
//  Created by Laurentiu Cociu on 9/18/25.
//

#if DEBUG
import UIKit

class ArtworkImageDataGenerator {
    static func generateImageData() -> Data {
        let size = CGSize(width: 150, height: 150)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image { context in
            UIColor.green.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        
        return image.jpegData(compressionQuality: 1.0)!
    }
}
#endif
