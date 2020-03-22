//
//  AttributedStringClass.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/18.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public final class AttributedStringClass {
    public typealias V = NSMutableAttributedString
    let _value: V
    init() {
        self._value = V()
    }
    init<T: AttributedStringCreater>(value: T?) {
        guard let value = value else {
            self._value = V()
            return
        }
        self._value = value.createMutableAttributedString()
    }
    func copy() -> Self {
        return Self(value: self._value)
    }
}
extension AttributedStringClass: ExpressibleByStringLiteral {
    public convenience init(stringLiteral value: String) {
        self.init(value: value)
    }
}
extension AttributedStringClass: CustomStringConvertible {
    public var description: String {
        "AttributedString: \(self._value))"
    }
}
public extension AttributedStringClass {
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
// MARK: -
extension AttributedStringClass: AttributedStringCreater {
    @inline(__always)
    public func createMutableAttributedString() -> NSMutableAttributedString {
        self._value.createMutableAttributedString()
    }
    @inline(__always)
    public func unsafeGetAttributedString() -> NSAttributedString {
        self._value.unsafeGetAttributedString()
    }
}
extension AttributedStringClass: AttributedStringAppendable {
    public func appending<T: AttributedStringCreater>(_ value: T) -> Self {
        append(value)
        return self
    }
    public func append<T: AttributedStringCreater>(_ value: T) {
        self._value.append(value.unsafeGetAttributedString())
    }
}
// MARK: -
extension AttributedStringClass {
    func setAttribute(_ key: NSAttributedString.Key, value: Any?, range: NSRange?) {
        let range = range ?? defaultRange
        if let value = value {
            _value.addAttribute(key, value: value, range: range)
        } else {
            _value.removeAttribute(key, range: range)
        }
    }
    @inline(__always)
    func setAttributes(_ attrs: [NSAttributedString.Key: Any], range: NSRange?) {
        attrs.forEach({setAttribute($0.key, value: $0.value, range: range)})
    }
}
extension AttributedStringClass {
    @inline(__always)
    func paragraphStyle(_ style: NSParagraphStyle?, range: NSRange?) {
        setAttribute(.paragraphStyle, value: style, range: range)
    }
    func paragraphStyleKeyPath<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, _ value: T, range: NSRange?) {
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
