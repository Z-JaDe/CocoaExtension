//
//  _AttributedString.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

// MARK: -
public protocol _AttributedString: ExpressibleByStringLiteral, CustomStringConvertible, AttributedStringCreater {
    typealias Style = AttributedStringStyle
    typealias V = NSMutableAttributedString
    var _value: V { get }
    init()
    init<T: AttributedStringCreater>(_ value: T?)
    mutating func append<T: AttributedStringCreater>(_ value: T)
}
public extension _AttributedString {
    func createMutableAttributedString() -> NSMutableAttributedString {
        self._value
    }
}
public extension _AttributedString {
    init(stringLiteral value: String) {
        self.init(value)
    }
}
public extension _AttributedString {
    var description: String {
        "AttributedString: \(self._value))"
    }
}
public extension _AttributedString {
    @inline(__always)
    var string: String {
        self._value.string
    }
    @inline(__always)
    func finalize() -> NSAttributedString {
        return _value.copy() as! NSAttributedString
    }
    @inline(__always)
    var defaultRange: NSRange {
        let string = self.string
        return NSRange(string.startIndex..<string.endIndex, in: string)
    }
}
