//
//  AttributedStringMergeStyle.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/18.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public protocol AttributedStringMergeStyle {
    typealias Style = AttributedString.Style
    associatedtype AttrString: _AttributedString
    func mergeStyle(_ style: Style...) -> AttrString
    func mergeStyles(_ style: [Style]) -> AttrString
}
public extension AttributedStringMergeStyle {
    @inline(__always)
    func mergeStyle(_ style: Style...) -> AttrString {
        mergeStyles(style)
    }
}
public extension AttributedStringCreater where Self: AttributedStringMergeStyle {
    func mergeStyles(_ style: [Style]) -> AttributedString {
        AttributedString(self).mergeStyles(style)
    }
}
extension AttributedString: AttributedStringMergeStyle {
    public func mergeStyles(_ style: [Style]) -> AttributedString {
        var result = self
        switch style.count {
        case 0:
            return result
        case 1:
            result.setAttributes(style[0].attributes, range: defaultRange)
        default:
            let style = style.reduce(into: Style(), {$0.merge($1)})
            result.setAttributes(style.attributes, range: defaultRange)
        }
        return result
    }
}
extension String: AttributedStringMergeStyle {}
extension UIImage: AttributedStringMergeStyle {}
extension NSTextAttachment: AttributedStringMergeStyle {}
extension NSAttributedString: AttributedStringMergeStyle {}
