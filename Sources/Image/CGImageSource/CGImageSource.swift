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
    static func create(with provider: CGDataProvider, _ options: CFDictionary? =  nil) -> CGImageSource? {
        CGImageSourceCreateWithDataProvider(provider, options)
    }
    static func create(with data: CFData, _ options: CFDictionary? =  nil) -> CGImageSource? {
        CGImageSourceCreateWithData(data, options)
    }
    static func create(with url: CFURL, _ options: CFDictionary? =  nil) -> CGImageSource? {
        CGImageSourceCreateWithURL(url, options)
    }
}
// MARK: Creating Images From an Image Source
public extension CGImageSource {
    func createImage(atIndex index: Int, _ options: CFDictionary? = nil) -> CGImage? {
        CGImageSourceCreateImageAtIndex(self, index, options)
    }
    func createThumbnail(atIndex index: Int, _ options: CFDictionary? = nil) -> CGImage? {
        CGImageSourceCreateThumbnailAtIndex(self, index, options)
    }
    func removeCache(atIndex index: Int) {
        CGImageSourceRemoveCacheAtIndex(self, index)
    }
    static func createIncremental(_ options: CFDictionary? = nil) -> CGImageSource {
        CGImageSourceCreateIncremental(options)
    }
}
// MARK: Updating an Image Source
public extension CGImageSource {
    func update(data: CFData, _ final: Bool) {
        CGImageSourceUpdateData(self, data, final)
    }
    func update(dataProvider provider: CGDataProvider, _ final: Bool) {
        CGImageSourceUpdateDataProvider(self, provider, final)
    }
}
// MARK: Getting Information From an Image Source
public extension CGImageSource {
    static var typeId: CFTypeID {
        CGImageSourceGetTypeID()
    }
    var type: CFString? {
        CGImageSourceGetType(self)
    }
    static func copyTypeIdentifiers() -> CFArray {
        CGImageSourceCopyTypeIdentifiers()
    }
    ///
    var count: Int {
        CGImageSourceGetCount(self)
    }
    ///
    func copyProperties(_ options: CFDictionary? = nil) -> CFDictionary? {
        CGImageSourceCopyProperties(self, options)
    }
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
    var status: CGImageSourceStatus {
        CGImageSourceGetStatus(self)
    }
    func getStatus(atIndex index: Int) -> CGImageSourceStatus {
        CGImageSourceGetStatusAtIndex(self, index)
    }
}
// MARK: Image I/O Functions
public extension CGImageSource {
    @available(iOS 12.0, *)
    var primaryImageIndex: Int {
        CGImageSourceGetPrimaryImageIndex(self)
    }
    @available(iOS 11.0, *)
    func copyAuxiliaryDataInfo(atIndex index: Int, _ auxiliaryImageDataType: CFString) -> CFDictionary? {
        CGImageSourceCopyAuxiliaryDataInfoAtIndex(self, index, auxiliaryImageDataType)
    }
}
public extension CGImageSource {
    func copyMetadata(atIndex index: Int, _ options: CFDictionary? = nil) -> CGImageMetadata? {
        CGImageSourceCopyMetadataAtIndex(self, index, options)
    }
}
