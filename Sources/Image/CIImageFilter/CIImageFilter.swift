//
//  CIImageFilter.swift
//  Any
//
//  Created by ZJaDe on 2018/6/20.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit

enum CIFilterName: String {
    case gaussianBlur = "CIGaussianBlur" /// ZJaDe: 高斯模糊
}
public class CIImageFilter {
    let ciContext: CIContext = {
        let eaglContext: EAGLContext = EAGLContext(api: .openGLES3)!
        let ciContext = CIContext(eaglContext: eaglContext, options: [.workingColorSpace: NSNull()])
        return ciContext
    }()
    let originImage: UIImage
    let originCIImage: CIImage
    public init(_ image: UIImage) {
        self.originImage = image
        self.originCIImage = CIImage(cgImage: image.cgImage!)
    }
    public func createImage() -> UIImage {
        guard let outputImage = self.outputImage else {
            return originImage
        }
        let cgImage: CGImage = self.ciContext.createCGImage(outputImage, from: originCIImage.extent)!
        return UIImage(cgImage: cgImage)
    }
    // MARK: -
    public func gaussianBlur(_ blur: CGFloat = 10) -> CIImageFilter {
        filterConfig(.gaussianBlur) { (filter) in
            filter.setValue(blur, forKey: kCIInputRadiusKey)
        }
        return self
    }

    // MARK: -
    private var outputImage: CIImage?
    func filterConfig(_ name: CIFilterName, _ closure: (CIFilter) -> Void) {
        let filter: CIFilter = CIFilter(name: name.rawValue)!
        filter.setValue(outputImage ?? originCIImage, forKey: kCIInputImageKey)
        closure(filter)
        self.outputImage = filter.outputImage
    }
}
import Accelerate
extension UIImage {
    @available(*, deprecated, message: "存在性能问题，可以使用gaussianBlur或者blurImage")
    public func gaussianBlurImage(_ blur: CGFloat = 10) -> UIImage {
        guard blur > 0 else {
            return self
        }
        return CIImageFilter(self).gaussianBlur(blur).createImage()
    }
}
