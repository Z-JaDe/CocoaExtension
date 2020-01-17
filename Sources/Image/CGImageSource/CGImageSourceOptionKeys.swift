//
//  CGImageSourceOptionKeys.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation
import ImageIO
public enum CGImageSourceOptionKeys {
    /**
     用于 CGImageSourceRef 的 key。
     指定最佳评估图片资源类型的格式类型id。
     这个值必须为CFStringRef 类型。
     可以通过查看 UTType.h 文件来了解具体类型id.
     */
    case typeIdentifierHint(CFString)
    /**
     指定如果被文件类型支持的话，图片是否要作为一个 floating  point CGImageRef 返回
     默认为false
    */
    case shouldAllowFloat(Bool)
    /**
     描述图片在decoded 模式下，是否需要被缓存
     32-bit默认为false 64-bit默认为true
    */
    case shouldCache(Bool)
    /**
     设置是否创建缩略图，如果原图像没有包含缩略图，则创建缩略图
     默认为false
    */
    case createThumbnailFromImageIfAbsent(Bool)
    /**
     限制缩略图的宽高尺寸，以像素为单位
     如果这个值没有被指定，thumbnail 的宽高不会被限制，thumbnail 会是尽可能的大
    */
    case thumbnailMaxPixelSize(Float)
    /**
     指定 thumbnail 是否会根据完整图片的方向和像素比例，被旋转或缩放
     默认为false
    */
    case createThumbnailWithTransform(Bool)
    /*
    指定，图片在某些情况下，是否可以缩小后返回。
    结果图片会变小，质量会被减少，但和全尺寸图片的其他特征一致。
    如果不支持，全尺寸或者更大的图片会被返回。
    支持如下类型：JPEG, HEIF, TIFF, and PNG。
    这个返回值必须是CFNumberRef 类型，允许值为：2、4、8。
    */
    case subsampleFactor(Int)
    /**
     指定是否在图片创建的时候，就解码和缓存
     默认为false
    */
    case shouldCacheImmediately(Bool)
}

extension Array where Element == CGImageSourceOptionKeys {
    func options() -> [CFString: Any] {
        reduce(into: [:]) { (result, key) in
            switch key {
            case .typeIdentifierHint(let value): result[kCGImageSourceTypeIdentifierHint] = value
            case .shouldAllowFloat(let value): result[kCGImageSourceShouldAllowFloat] = value
            case .shouldCache(let value): result[kCGImageSourceShouldCache] = value
            case .createThumbnailFromImageIfAbsent(let value): result[kCGImageSourceCreateThumbnailFromImageIfAbsent] = value
            case .thumbnailMaxPixelSize(let value): result[kCGImageSourceThumbnailMaxPixelSize] = value
            case .createThumbnailWithTransform(let value): result[kCGImageSourceCreateThumbnailWithTransform] = value
            case .subsampleFactor(let value): result[kCGImageSourceSubsampleFactor] = value
            case .shouldCacheImmediately(let value): result[kCGImageSourceShouldCacheImmediately] = value
            }
        }
    }
    func cfOptions() -> CFDictionary {
        options() as CFDictionary
    }
}
