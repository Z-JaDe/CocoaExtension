//
//  UIImage+GIF.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public extension UIImage {
    static func animatedGIF(withData data: Data) -> UIImage? {
        guard let source = CGImageSource.create(with: data as CFData) else {
            return UIImage(data: data)
        }
        let count = source.count
        guard count > 1 else {
            return UIImage(data: data)
        }
        var result: (images: [UIImage], duration: TimeInterval) = (0..<count).reduce(into: (images: [], duration: 0)) { (result, index) in
            guard let image = source.createImage(atIndex: index) else {
                return
            }
            result.images.append(UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .up))
            result.duration += TimeInterval(source.frameDuration(atIndex: index))
        }
        if result.duration <= 0 {
            result.duration = 0.1 * TimeInterval(count)
        }
        return UIImage.animatedImage(with: result.images, duration: result.duration)
    }
    static func animatedGIF(withName name: String) -> UIImage? {
        let file = FileNameExtension(name: name, defaultExten: "gif")
        if let data = file.getData(file.getImagePath()) {
            return animatedGIF(withData: data)
        }
        return UIImage(named: name)
    }
}
