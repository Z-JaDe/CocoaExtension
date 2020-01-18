//
//  _AttributedString+Attributes.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/18.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public extension AttributedStringClass {
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
        _value.addAttributes(attrs, range: range ?? defaultRange)
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
public extension AttributedString {
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
    mutating func paragraphStyleKeyPath<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, value: T, range: NSRange?) {
        _boxForWriting.paragraphStyleKeyPath(keyPath, value: value, range: range)
    }
}
