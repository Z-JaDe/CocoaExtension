//
//  AttributedStringStyle.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation
public extension AttributedStringCompatible {
    @inline(__always)
    func color(_ value: UIColor) -> Self {
        merging(key: .foregroundColor, value: value)
    }
    @inline(__always)
    func bgColor(_ value: UIColor) -> Self {
        merging(key: .backgroundColor, value: value)
    }
    @inline(__always)
    func font(_ value: UIFont) -> Self {
        merging(key: .font, value: value)
    }
}
public extension AttributedStringCompatible {
    @inline(__always)
    var oblique: Self {
        merging(key: .obliqueness, value: 0.1)
    }
    @inline(__always)
    func underline(_ value: UIColor, _ style: NSUnderlineStyle = .single) -> Self {
        merging([
            .underlineColor: value as Any,
            .underlineStyle: style.rawValue
        ])
    }
    @inline(__always)
    func deleteLine(_ value: UIColor, _ style: NSUnderlineStyle = .single) -> Self {
        merging([
            .strikethroughColor: value as Any,
            .strikethroughStyle: style.rawValue
        ])
    }
    @inline(__always)
    func kern(_ value: Double) -> Self {
        merging(key: .kern, value: NSNumber(value: value))
    }
    @inline(__always)
    func link(_ value: URL) -> Self {
        merging(key: .link, value: value)
    }
    @inline(__always)
    func link(_ value: String) -> Self {
        URL(string: value).map({link($0)}) ?? self
    }
}

// MARK: paragraphStyle
public extension AttributedStringCompatible {
    @inline(__always)
    func alignment(_ value: NSTextAlignment) -> Self {
        mergingParagraphStyleKeyPath(\.alignment, value)
    }
    @inline(__always)
    func lineSpacing(_ value: CGFloat) -> Self {
        mergingParagraphStyleKeyPath(\.lineSpacing, value)
    }
}
