//
//  AttributedString.swift
//  AppExtension
//
//  Created by Apple on 2019/10/14.
//  Copyright © 2019 ZJaDe. All rights reserved.
//

import Foundation

public struct AttributedString {
    typealias Box = AttributedStringClass
    private var _box: Box
    private var _boxForReading: Box { _box }
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
    init<T: AttributedStringCreater>(value: T?) {
        self._box = Box(value: value)
    }
}
extension AttributedString: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value: value)
    }
}
extension AttributedString: CustomStringConvertible {
    public var description: String {
        _boxForReading.description
    }
}
public extension AttributedString {
    @inline(__always)
    var string: String {
        _boxForReading.string
    }
    @inline(__always)
    func finalize() -> NSAttributedString {
        _boxForReading.finalize()
    }
    @inline(__always)
    var defaultRange: NSRange {
        _boxForReading.defaultRange
    }
}
// MARK: -
extension AttributedString: AttributedStringCreater {
    @inline(__always)
    public func createMutableAttributedString() -> NSMutableAttributedString {
        self._boxForReading.createMutableAttributedString()
    }
    @inline(__always)
    public func unsafeGetAttributedString() -> NSAttributedString {
        self._boxForReading.unsafeGetAttributedString()
    }
}
extension AttributedString: AttributedStringAppendable {
    @inline(__always)
    public mutating func append<T: AttributedStringCreater>(_ value: T) {
        _boxForWriting.append(value)
    }
    public func appending<T: AttributedStringCreater>(_ value: T) -> Self {
        var result = self
        result.append(value)
        return result
    }
    public static func + <T: AttributedStringCreater>(left: AttributedString, right: T) -> AttributedString {
        left.appending(right)
    }
    public static func += <T: AttributedStringCreater>(left: inout AttributedString, right: T) {
        left.append(right)
    }
}
// MARK: -
extension AttributedString {
    @inline(__always)
    mutating func setAttribute(_ key: NSAttributedString.Key, value: Any?, range: NSRange?) {
        _boxForWriting.setAttribute(key, value: value, range: range)
    }
    @inline(__always)
    mutating func setAttributes(_ attrs: [NSAttributedString.Key: Any], range: NSRange?) {
        _boxForWriting.setAttributes(attrs, range: range)
    }
    @inline(__always)
    mutating func paragraphStyle(_ style: NSParagraphStyle?, range: NSRange?) {
        _boxForWriting.paragraphStyle(style, range: range)
    }
    @inline(__always)
    mutating func paragraphStyleKeyPath<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, _ value: T, range: NSRange?) {
        _boxForWriting.paragraphStyleKeyPath(keyPath, value, range: range)
    }
}
