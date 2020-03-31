//
//  AttributedStringCompatible.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

// MARK: -
public protocol AttributedStringCompatible {
    func merging<V>(key: NSAttributedString.Key, value: V) -> Self
    func merging(_ attrs: [NSAttributedString.Key: Any]) -> Self
    func mergingParagraphStyle(_ style: NSParagraphStyle?) -> Self
    func mergingParagraphStyleKeyPath<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, _ value: T) -> Self
}

extension AttributedStringClass: AttributedStringCompatible {
    public func merging(_ attrs: [NSAttributedString.Key: Any]) -> Self {
        setAttributes(attrs, range: nil)
        return self
    }
    public func merging<V>(key: NSAttributedString.Key, value: V) -> Self {
        setAttribute(key, value: value, range: nil)
        return self
    }
    public func mergingParagraphStyle(_ style: NSParagraphStyle?) -> Self {
        paragraphStyle(style, range: nil)
        return self
    }
    public func mergingParagraphStyleKeyPath<T>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, _ value: T) -> Self where T: Equatable {
        paragraphStyleKeyPath(keyPath, value, range: nil)
        return self
    }
}
extension AttributedString: AttributedStringCompatible {
    public func merging(_ attrs: [NSAttributedString.Key: Any]) -> AttributedString {
        var result = self
        result.setAttributes(attrs, range: nil)
        return result
    }
    public func merging<V>(key: NSAttributedString.Key, value: V) -> AttributedString {
        var result = self
        result.setAttribute(key, value: value, range: nil)
        return result
    }
    public func mergingParagraphStyle(_ style: NSParagraphStyle?) -> AttributedString {
        var result = self
        result.paragraphStyle(style, range: nil)
        return result
    }
    public func mergingParagraphStyleKeyPath<T>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, _ value: T) -> AttributedString where T: Equatable {
        var result = self
        result.paragraphStyleKeyPath(keyPath, value, range: nil)
        return result
    }
}
// MARK: -
extension String {
    @inline(__always)
    public func asAttributedString() -> AttributedString {
        AttributedString(value: self)
    }
    @inline(__always)
    public func asAttributedStringClass() -> AttributedStringClass {
        AttributedStringClass(value: self)
    }
}
extension UIImage {
    @inline(__always)
    public func asAttributedString() -> AttributedString {
        AttributedString(value: self)
    }
    @inline(__always)
    public func asAttributedStringClass() -> AttributedStringClass {
        AttributedStringClass(value: self)
    }
}
extension NSTextAttachment {
    @inline(__always)
    public func asAttributedString() -> AttributedString {
        AttributedString(value: self)
    }
    @inline(__always)
    public func asAttributedStringClass() -> AttributedStringClass {
        AttributedStringClass(value: self)
    }
}
extension NSAttributedString {
    @inline(__always)
    public func asAttributedString() -> AttributedString {
        AttributedString(value: self)
    }
    @inline(__always)
    public func asAttributedStringClass() -> AttributedStringClass {
        AttributedStringClass(value: self)
    }
}

extension NSAttributedString {
    @inline(__always)
    public static func build(content: () -> AttributedString) -> NSAttributedString {
        content().finalize()
    }
}
extension AttributedString {
    @inline(__always)
    public static func build(content: () -> AttributedString) -> AttributedString {
        content()
    }
}
extension UILabel {
    @inline(__always)
    public func makeAttrStr(content: () -> AttributedString) {
        self.attributedText = NSAttributedString.build(content: content)
    }
}
