//
//  CGImageSource.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

// MARK: Creating an Image Source
public extension CGImageSource {
    @inline(__always)
    static func create(with provider: CGDataProvider, _ options: CFDictionary? =  nil) -> CGImageSource? {
        CGImageSourceCreateWithDataProvider(provider, options)
    }
    @inline(__always)
    static func create(with data: CFData, _ options: CFDictionary? =  nil) -> CGImageSource? {
        CGImageSourceCreateWithData(data, options)
    }
    @inline(__always)
    static func create(with url: CFURL, _ options: CFDictionary? =  nil) -> CGImageSource? {
        CGImageSourceCreateWithURL(url, options)
    }
}
// MARK: Creating Images From an Image Source
public extension CGImageSource {
    @inline(__always)
    func createImage(atIndex index: Int, _ options: CFDictionary? = nil) -> CGImage? {
        CGImageSourceCreateImageAtIndex(self, index, options)
    }
    @inline(__always)
    func createThumbnail(atIndex index: Int, _ options: CFDictionary? = nil) -> CGImage? {
        CGImageSourceCreateThumbnailAtIndex(self, index, options)
    }
    @inline(__always)
    func removeCache(atIndex index: Int) {
        CGImageSourceRemoveCacheAtIndex(self, index)
    }
    @inline(__always)
    static func createIncremental(_ options: CFDictionary? = nil) -> CGImageSource {
        CGImageSourceCreateIncremental(options)
    }
}
// MARK: Updating an Image Source
public extension CGImageSource {
    @inline(__always)
    func update(data: CFData, _ final: Bool) {
        CGImageSourceUpdateData(self, data, final)
    }
    @inline(__always)
    func update(dataProvider provider: CGDataProvider, _ final: Bool) {
        CGImageSourceUpdateDataProvider(self, provider, final)
    }
}
// MARK: Getting Information From an Image Source
public extension CGImageSource {
    @inline(__always)
    static var typeId: CFTypeID {
        CGImageSourceGetTypeID()
    }
    @inline(__always)
    var type: CFString? {
        CGImageSourceGetType(self)
    }
    @inline(__always)
    static func copyTypeIdentifiers() -> CFArray {
        CGImageSourceCopyTypeIdentifiers()
    }
    ///
    @inline(__always)
    var count: Int {
        CGImageSourceGetCount(self)
    }
    ///
    @inline(__always)
    func copyProperties(_ options: CFDictionary? = nil) -> CFDictionary? {
        CGImageSourceCopyProperties(self, options)
    }
    @inline(__always)
    func copyProperties(atIndex index: Int, _ options: CFDictionary? = nil) -> CFDictionary? {
        CGImageSourceCopyPropertiesAtIndex(self, index, options)
    }
    func frameDuration(atIndex index: Int) -> Double {
        var frameDuration: Double = 0.1
        if let frameProperties = self.copyProperties(atIndex: index) {
            let frameProperties = frameProperties as NSDictionary
            let gifProperties = frameProperties.object(forKey: kCGImagePropertyGIFDictionary) as? NSDictionary
            if let delayTimeUnclampedProp = gifProperties?.object(forKey: kCGImagePropertyGIFUnclampedDelayTime) as? NSNumber {
                frameDuration = delayTimeUnclampedProp.doubleValue
            } else if let delayTimeProp = gifProperties?.object(forKey: kCGImagePropertyGIFDelayTime) as? NSNumber {
                frameDuration = delayTimeProp.doubleValue
            }
        }
        // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
        // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
        // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
        // for more information.
        if frameDuration < 0.011 {
            frameDuration = 0.1
        }
        return frameDuration
    }
    ///
    @inline(__always)
    var status: CGImageSourceStatus {
        CGImageSourceGetStatus(self)
    }
    @inline(__always)
    func getStatus(atIndex index: Int) -> CGImageSourceStatus {
        CGImageSourceGetStatusAtIndex(self, index)
    }
}
// MARK: Image I/O Functions
public extension CGImageSource {
    @available(iOS 12.0, *)
    @inline(__always)
    var primaryImageIndex: Int {
        CGImageSourceGetPrimaryImageIndex(self)
    }
    @available(iOS 11.0, *)
    @inline(__always)
    func copyAuxiliaryDataInfo(atIndex index: Int, _ auxiliaryImageDataType: CFString) -> CFDictionary? {
        CGImageSourceCopyAuxiliaryDataInfoAtIndex(self, index, auxiliaryImageDataType)
    }
}
public extension CGImageSource {
    @inline(__always)
    func copyMetadata(atIndex index: Int, _ options: CFDictionary? = nil) -> CGImageMetadata? {
        CGImageSourceCopyMetadataAtIndex(self, index, options)
    }
}
