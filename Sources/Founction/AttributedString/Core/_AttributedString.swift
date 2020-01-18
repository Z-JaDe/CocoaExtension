//
//  _AttributedString.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

// MARK: -
public protocol _AttributedString: CustomStringConvertible, AttributedStringCreater {
    typealias Style = AttributedStringStyle
    typealias V = NSMutableAttributedString
    var _value: V { get }
    init()
    init<T: AttributedStringCreater>(_ value: T?)
    mutating func append<T: AttributedStringCreater>(_ value: T)
    func appending<T: AttributedStringCreater>(_ value: T) -> Self
    mutating func setAttributes(_ attrs: [NSAttributedString.Key: Any], range: NSRange?)
}
public extension _AttributedString {
    func appending<T: AttributedStringCreater>(_ value: T) -> Self {
        var result = self
        result.append(value)
        return result
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
        // swiftlint:disable force_cast
        return _value.copy() as! NSAttributedString
    }
    @inline(__always)
    var defaultRange: NSRange {
        let string = self.string
        return NSRange(string.startIndex..<string.endIndex, in: string)
    }
}
