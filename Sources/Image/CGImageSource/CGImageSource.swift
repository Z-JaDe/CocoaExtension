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
