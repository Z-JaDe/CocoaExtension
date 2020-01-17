//
//  AttributedString.swift
//  AppExtension
//
//  Created by Apple on 2019/10/14.
//  Copyright © 2019 ZJaDe. All rights reserved.
//

import Foundation
// MARK: -
public final class AttributedStringClass: _AttributedString {
    public typealias V = NSMutableAttributedString
    public let _value: V
    public init() {
        self._value = V()
    }
    public init<T: AttributedStringCreater>(_ value: T?) {
        guard let value = value else {
            self._value = V()
            return
        }
        self._value = value.createMutableAttributedString()
    }
    public func append<T: AttributedStringCreater>(_ value: T) {
        self._value.append(value.unsafeGetAttributedString())
    }
    public func copy() -> Self {
        return Self(self._value)
    }
}
public extension AttributedStringClass {
    @inline(__always)
    func map(_ style: Style..., range: NSRange?) {
        map(style, range: range)
    }
    @inline(__always)
    func map(_ style: [Style], range: NSRange?) {
        let range = range ?? defaultRange
        let style = style.reduce(into: Style(), {$0.merge($1)})
        self.setAttributes(style.attributes, range: range)
    }
    @inline(__always)
    func setAttribute(_ key: NSAttributedString.Key, value: Any?, range: NSRange?) {
        let range = range ?? defaultRange
        if let value = value {
            _value.addAttribute(key, value: value, range: range)
        } else {
            _value.removeAttribute(key, range: range)
        }
    }
    @inline(__always)
    func setAttributes(_ attrs: [NSAttributedString.Key : Any], range: NSRange?) {
        let range = range ?? defaultRange
        _value.addAttributes(attrs, range: range)
    }
    @inline(__always)
    func paragraphStyle(_ style: NSParagraphStyle?, range: NSRange?) {
        setAttribute(.paragraphStyle, value: style, range: range)
    }
    func paragraphStyleKeyPath<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, value: T, range: NSRange?) {
        let range = range ?? defaultRange
        _value.enumerateAttribute(.paragraphStyle, in: range, options: []) { (_style, _, _) in
            let style: NSMutableParagraphStyle = {
                switch _style {
                case let style as NSMutableParagraphStyle:
                    return style
                case let style as NSParagraphStyle:
                    // swiftlint:disable force_cast
                    return style.mutableCopy() as! NSMutableParagraphStyle
                default:
                    // swiftlint:disable force_cast
                    return NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
                }
            }()
            if style[keyPath: keyPath] == value {return}
            style[keyPath: keyPath] = value
            self.paragraphStyle(style, range: range)
        }
    }
}

// MARK: -
public struct AttributedString: _AttributedString {
    typealias Box = AttributedStringClass
    private var _box: Box
    public var _value: V {
        _box._value
    }
    private var _boxForWriting: Box {
        mutating get {
            if !isKnownUniquelyReferenced(&_box) {
                _box = _box.copy()
            }
            return _box
        }
    }
    public init() {
        self._box = Box()
    }
    public init<T: AttributedStringCreater>(_ value: T?) {
        self._box = Box(value)
    }
    @inline(__always)
    public mutating func append<T: AttributedStringCreater>(_ value: T) {
        self._boxForWriting.append(value)
    }
}
public extension AttributedString {
    @inline(__always)
    func map(_ style: [Style], range: NSRange? = nil) -> Self {
        var attrStr = self
        attrStr._boxForWriting.map(style, range: range)
        return attrStr
    }
    @inline(__always)
    func map(_ style: Style..., range: NSRange? = nil) -> Self {
        map(style, range: range)
    }
}
public extension AttributedString {
    @inline(__always)
    mutating func setAttribute(_ key: NSAttributedString.Key, value: Any?, range: NSRange?) {
        _boxForWriting.setAttribute(key, value: value, range: range)
    }
    @inline(__always)
    mutating func setAttributes(_ attrs: [NSAttributedString.Key : Any], range: NSRange?) {
        _boxForWriting.setAttributes(attrs, range: range)
    }
    @inline(__always)
    mutating func paragraphStyle(_ style: NSParagraphStyle?, range: NSRange?) {
        _boxForWriting.paragraphStyle(style, range: range)
    }
    @inline(__always)
    mutating func paragraphStyleKeyPath<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, value: T, range: NSRange?) {
        _boxForWriting.paragraphStyleKeyPath(keyPath, value: value, range: range)
    }
}
