//
//  CIImageFilter.swift
//  Any
//
//  Created by ZJaDe on 2018/6/20.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit

enum CIFilterName: String {
    /// ZJaDe: 高斯模糊 kCIInputImageKey
    case gaussianBlur = "CIGaussianBlur"
    /// ZJaDe: Blurs an image using a box-shaped convolution kernel.
    case boxBlur = "CIBoxBlur"
    /// ZJaDe: Blurs an image using a disc-shaped convolution kernel.
    case discBlur = "CIDiscBlur"

    /// ZJaDe: 调整饱和度，亮度和对比度值 kCIInputSaturationKey 饱和度 kCIInputBrightnessKey 亮度 kCIInputContrastKey 对比度
    case colorControls = "CIColorControls"
    /// ZJaDe: 曝光调整 kCIInputEVKey 曝光度
    case exposureAdjust = "CIExposureAdjust"
}
public class CIImageFilter {
    let ciContext: CIContext = CIContext()
    let originImage: UIImage?
    let originCIImage: CIImage?
    public init(_ image: UIImage? = nil) {
        self.originImage = image
        self.originCIImage = image?.ciImage
    }
    public func createImage() -> UIImage? {
        guard let cgImage = self.createCGImage() else { return nil }
        return UIImage(cgImage: cgImage)
    }
    public func createCGImage() -> CGImage? {
        guard let outputImage = self.outputImage else { return nil }
        return ciContext.createCGImage(outputImage, from: outputImage.extent)!
    }
    // MARK: -
    public func gaussianBlur(_ blur: CGFloat = 10) -> CIImageFilter {
        addFilter(.gaussianBlur) { (filter) in
            filter.setValue(blur, forKey: kCIInputRadiusKey)
        }
        return self
    }

    // MARK: -
    private var outputImage: CIImage?
    func addFilter(_ name: CIFilterName, _ closure: (CIFilter) -> Void) {
        addFilter(CIFilter(name: name.rawValue)!, closure)
    }
    func addFilter(_ filterName: String, _ closure: (CIFilter) -> Void) {
        if let filter = CIFilter(name: filterName) {
            addFilter(filter, closure)            
        }
    }
    func addFilter(_ filter: CIFilter, _ closure: (CIFilter) -> Void) {
        if let image = outputImage ?? originCIImage {
            filter.setValue(image, forKey: kCIInputImageKey)
        }
        closure(filter)
        self.outputImage = filter.outputImage
    }
}

extension UIImage {
    public func gaussianBlurImage(_ blur: CGFloat = 10) -> UIImage {
        guard blur > 0 else {
            return self
        }
        return CIImageFilter(self).gaussianBlur(blur).createImage()!
    }
}
