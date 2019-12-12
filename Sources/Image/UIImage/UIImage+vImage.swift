//
//  UIImage+vImage.swift
//  CocoaExtension
//
//  Created by Apple on 2019/12/12.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation
import Accelerate
let gaussianblur_kernel: [Int16] = [
    1, 4, 6, 4, 1,
    4, 16, 24, 16, 4,
    6, 24, 36, 24, 6,
    4, 16, 24, 16, 4,
    1, 4, 6, 4, 1
]
let edgedetect_kernel: [Int16] = [
    -1, -1, -1,
    -1, 8, -1,
    -1, -1, -1
]
let emboss_kernel: [Int16] = [
    -2, 0, 0,
    0, 1, 0,
    0, 0, 2
]
let sharpen_kernel: [Int16] = [
    -1, -1, -1,
    -1, 9, -1,
    -1, -1, -1
]
let unsharpen_kernel: [Int16] = [
    -1, -1, -1,
    -1, 17, -1,
    -1, -1, -1
]
let backgroundColorBlack: [UInt8] = [0, 0, 0, 0]

let morphological_kernel: [CUnsignedChar] = [
    1, 1, 1,
    1, 1, 1,
    1, 1, 1
]
//let morphological_kernel: CUnsignedChar = [
//    0, 1, 1, 1, 0,
//    1, 1, 1, 1, 1,
//    1, 1, 1, 1, 1,
//    1, 1, 1, 1, 1,
//    0, 1, 1, 1, 0
//]

extension UIImage {
    func accelerateBlurShort(blur: Int) -> UIImage? {
        var boxSize = blur
        if blur < 1 || blur > 100 {
            boxSize = 25
        }
        boxSize = boxSize - (boxSize % 2) + 1;
        return vImage_image { (src, dest) in
            vImageBoxConvolve_ARGB8888(&src, &dest, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        }
    }
    // MARK: Convolution Oprations
    var gaussianBlur: UIImage? {
        vImage_image { (src, dest) in
            vImageConvolve_ARGB8888(&src, &dest, nil, 0, 0, gaussianblur_kernel, 5, 5, 256, nil, vImage_Flags(kvImageCopyInPlace))
        }
    }
    var edgeDetection: UIImage? {
        vImage_image { (src, dest) in
            vImageConvolve_ARGB8888(&src, &dest, nil, 0, 0, edgedetect_kernel, 3, 3, 1, backgroundColorBlack, vImage_Flags(kvImageCopyInPlace))
        }
    }
    var emboss: UIImage? {
        vImage_image { (src, dest) in
            vImageConvolve_ARGB8888(&src, &dest, nil, 0, 0, emboss_kernel, 3, 3, 1, nil, vImage_Flags(kvImageCopyInPlace))
        }
    }
    var sharpen: UIImage? {
        vImage_image { (src, dest) in
            vImageConvolve_ARGB8888(&src, &dest, nil, 0, 0, sharpen_kernel, 3, 3, 1, nil, vImage_Flags(kvImageCopyInPlace))
        }
    }
    var unsharpen: UIImage? {
        vImage_image { (src, dest) in
            vImageConvolve_ARGB8888(&src, &dest, nil, 0, 0, unsharpen_kernel, 3, 3, 9, nil, vImage_Flags(kvImageCopyInPlace))
        }
    }
    // MARK: Geometric Operations
    func rotate(inRadians radians: Float) -> UIImage? {
//        if &vImageRotate_ARGB8888 == nil {
//            return nil
//        }
        vImage_image(mallocDestData: false) { (src, dest) in
            let bgColor: [UInt8] = [0, 0, 0, 0]
            vImageRotate_ARGB8888(&src, &dest, nil, radians, bgColor, vImage_Flags(kvImageBackgroundColorFill))
        }
    }
    // MARK: Morphological Operations
    var dilate: UIImage? {
        vImage_image { (src, dest) in
            vImageDilate_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, vImage_Flags(kvImageCopyInPlace))
        }
    }
    var erode: UIImage? {
        vImage_image { (src, dest) in
            vImageErode_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, vImage_Flags(kvImageCopyInPlace))
        }
    }
    // MARK: Histogram Operations
    var equalization: UIImage? {
        vImage_image(mallocDestData: false) { (src, dest) in
            vImageEqualization_ARGB8888(&src, &dest, vImage_Flags(kvImageNoFlags))
        }
    }
}
extension UIImage {
    func vImage_image(mallocDestData: Bool = true, _ closure: (_ src: inout vImage_Buffer, _ src: inout vImage_Buffer) -> Void) -> UIImage? {
        let width: size_t = size_t(self.size.width)
        let height: size_t = size_t(self.size.height)
        let bytesPerRow: size_t = width * 4
        guard let cgImage = self.cgImage else { return nil }
        let space = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageByteOrderInfo.orderDefault.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
        guard let bmContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: space, bitmapInfo: bitmapInfo) else { return nil }
        bmContext.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let inData = bmContext.data else { return nil }
        var src = vImage_Buffer(data: inData, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: bytesPerRow)
        if mallocDestData {
            let n = MemoryLayout<UInt8>.size * width * height * 4
            let outData = malloc(n)
            var dest = vImage_Buffer(data: outData, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: bytesPerRow)
            closure(&src, &dest)

            memcpy(inData, outData, n)
            free(outData)
        } else {
            var dest = vImage_Buffer(data: inData, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: bytesPerRow)
            closure(&src, &dest)
        }
        guard let result_cgImage = bmContext.makeImage() else { return nil }
        return UIImage(cgImage: result_cgImage)
    }
}
