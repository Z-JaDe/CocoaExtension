//
//  AttributedStringStyle.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation
public extension AttributedStringCompatible {
    func color(_ value: UIColor) -> Self {
        merging(key: .foregroundColor, value: value)
    }
    func bgColor(_ value: UIColor) -> Self {
        merging(key: .backgroundColor, value: value)
    }
    func font(_ value: UIFont) -> Self {
        merging(key: .font, value: value)
    }
}
public extension AttributedStringCompatible {
    var oblique: Self {
        merging(key: .obliqueness, value: 0.1)
    }
    func underline(_ value: UIColor, _ style: NSUnderlineStyle = .single) -> Self {
        merging([
            .underlineColor: value as Any,
            .underlineStyle: style.rawValue
        ])
    }
    func deleteLine(_ value: UIColor, _ style: NSUnderlineStyle = .single) -> Self {
        merging([
            .strikethroughColor: value as Any,
            .strikethroughStyle: style.rawValue
        ])
    }
    func kern(_ value: Double) -> Self {
        merging(key: .kern, value: NSNumber(value: value))
    }
    func link(_ value: URL) -> Self {
        merging(key: .link, value: value)
    }
    func link(_ value: String) -> Self {
        URL(string: value).map({link($0)}) ?? self
    }
}

// MARK: paragraphStyle
public extension AttributedStringCompatible {
    func alignment(_ value: NSTextAlignment) -> Self {
        mergingParagraphStyleKeyPath(\.alignment, value)
    }
    func lineSpacing(_ value: CGFloat) -> Self {
        mergingParagraphStyleKeyPath(\.lineSpacing, value)
    }
}
