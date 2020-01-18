//
//  AttributedString.swift
//  AppExtension
//
//  Created by Apple on 2019/10/14.
//  Copyright © 2019 ZJaDe. All rights reserved.
//

import Foundation

public struct AttributedString: _AttributedString {
    typealias Box = AttributedStringClass
    private var _box: Box
    public var _value: V {
        _box._value
    }
    internal var _boxForWriting: Box {
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
extension AttributedString: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}
extension AttributedString {
    public static func + (left: AttributedString, right: AttributedString) -> AttributedString {
        left.appending(right)
    }
    public static func + (left: inout AttributedString, right: AttributedString) {
        left.append(right)
    }
}
