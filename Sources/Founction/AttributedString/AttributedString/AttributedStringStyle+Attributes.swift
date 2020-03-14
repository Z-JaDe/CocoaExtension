//
//  AttributedStringStyle+Attributes.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation
public extension AttributedString.Style {
    @inline(__always)
    static func color(_ value: UIColor) -> Self {
        Self().color(value)
    }
    @inline(__always)
    func color(_ value: UIColor) -> Self {
        merging(key: .foregroundColor, value: value)
    }
    @inline(__always)
    static func bgColor(_ value: UIColor) -> Self {
        Self().bgColor(value)
    }
    @inline(__always)
    func bgColor(_ value: UIColor) -> Self {
        merging(key: .backgroundColor, value: value)
    }
    @inline(__always)
    static func font(_ value: UIFont) -> Self {
        Self().font(value)
    }
    @inline(__always)
    func font(_ value: UIFont) -> Self {
        merging(key: .font, value: value)
    }
}
public extension AttributedString.Style {
    @inline(__always)
    static var oblique: Self {
         Self().oblique
    }
    @inline(__always)
    var oblique: Self {
        merging(key: .obliqueness, value: 0.1)
    }
    @inline(__always)
    static func underLine(_ value: UIColor, _ style: NSUnderlineStyle = .single) -> Self {
        Self().underline(value, style)
    }
    @inline(__always)
    func underline(_ value: UIColor, _ style: NSUnderlineStyle = .single) -> Self {
        merging([
            .underlineColor: value as Any,
            .underlineStyle: style.rawValue
        ])
    }
    @inline(__always)
    static func underline(_ value: UIColor, _ style: NSUnderlineStyle = .single) -> Self {
        Self().deleteLine(value, style)
    }
    @inline(__always)
    func deleteLine(_ value: UIColor, _ style: NSUnderlineStyle = .single) -> Self {
        merging([
            .strikethroughColor: value as Any,
            .strikethroughStyle: style.rawValue
        ])
    }
    @inline(__always)
    static func kern(_ value: Double) -> Self {
        Self().kern(value)
    }
    @inline(__always)
    func kern(_ value: Double) -> Self {
        merging(key: .kern, value: NSNumber(value: value))
    }
    @inline(__always)
    static func link(_ value: URL) -> Self {
        Self().link(value)
    }
    @inline(__always)
    func link(_ value: URL) -> Self {
        merging(key: .link, value: value)
    }
    @inline(__always)
    static func link(_ value: String) -> Self {
        Self().link(value)
    }
    @inline(__always)
    func link(_ value: String) -> Self {
        URL(string: value).map({link($0)}) ?? self
    }
}

// MARK: paragraphStyle
public extension AttributedString.Style {
    @inline(__always)
    static func paragraphStyle(_ value: NSParagraphStyle) -> Self {
        Self().paragraphStyle(value)
    }
    @inline(__always)
    func paragraphStyle(_ value: NSParagraphStyle) -> Self {
        merging(key: .paragraphStyle, value: value)
    }
    static func paragraphStyleKeyPath<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, _ value: T) -> Self {
        Self().paragraphStyleKeyPath(keyPath, value)
    }
    func paragraphStyleKeyPath<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, _ value: T) -> Self {
        let style: NSMutableParagraphStyle = {
            switch self.attributes[.paragraphStyle] {
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
        if style[keyPath: keyPath] == value { return self }
        style[keyPath: keyPath] = value
        return paragraphStyle(style)
    }
}
public extension AttributedString.Style {
    @inline(__always)
    static func alignment(_ value: NSTextAlignment) -> Self {
        Self().alignment(value)
    }
    @inline(__always)
    func alignment(_ value: NSTextAlignment) -> Self {
        paragraphStyleKeyPath(\.alignment, value)
    }
    @inline(__always)
    static func lineSpacing(_ value: CGFloat) -> Self {
        Self().lineSpacing(value)
    }
    @inline(__always)
    func lineSpacing(_ value: CGFloat) -> Self {
        paragraphStyleKeyPath(\.lineSpacing, value)
    }
}
