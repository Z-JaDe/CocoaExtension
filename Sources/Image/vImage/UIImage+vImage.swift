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
// let morphological_kernel: CUnsignedChar = [
//    0, 1, 1, 1, 0,
//    1, 1, 1, 1, 1,
//    1, 1, 1, 1, 1,
//    1, 1, 1, 1, 1,
//    0, 1, 1, 1, 0
// ]

public extension UIImage {
    func accelerateBlurShort(withRadius radius: CGFloat) -> UIImage? {
        if radius < 2 {
            return self
        }
        // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
        // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
        // if d is odd, use three box-blurs of size 'd', centered on the output pixel.
        let s = max(radius, 2.0)
        // We will do blur on a resized image (*0.5), so the blur radius could be half as well.

        // Fix the slow compiling time for Swift 3.
        // See https://github.com/onevcat/Kingfisher/issues/611
        let pi2 = 2 * CGFloat.pi
        let sqrtPi2 = sqrt(pi2)
        var targetRadius = floor(s * 3.0 * sqrtPi2 / 4.0 + 0.5)

        // 如果是偶数 +1
        if targetRadius.truncatingRemainder(dividingBy: 2.0) == 0 { targetRadius += 1 }
        return vImage_image { (src, dest) in
            vImageBoxConvolve_ARGB8888(&src, &dest, nil, 0, 0, UInt32(targetRadius), UInt32(targetRadius), nil, vImage_Flags(kvImageEdgeExtend))
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
        imageContext(inverting: true).draw { (context) in
            guard let cgImage = cgImage else { return }
            context.draw(cgImage, in: CGRect(origin: .zero, size: self.size))
            guard let inData = context.data else { return }
            var src = createEffectBuffer(context, inData)

            if mallocDestData {
                let n = MemoryLayout<UInt8>.size * context.bytesPerRow * context.height
                let outData = malloc(n)
                var dest = createEffectBuffer(context, outData)
                closure(&src, &dest)

                memcpy(inData, outData, n)
                free(outData)
            } else {
                var dest = createEffectBuffer(context, inData)
                closure(&src, &dest)
            }
        }
    }
    func createEffectBuffer(_ context: CGContext, _ data: UnsafeMutableRawPointer?) -> vImage_Buffer {
        return vImage_Buffer(data: data, height: vImagePixelCount(context.height), width: vImagePixelCount(context.width), rowBytes: context.bytesPerRow)
    }
}
