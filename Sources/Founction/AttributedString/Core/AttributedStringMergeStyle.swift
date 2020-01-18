//
//  AttributedStringMergeStyle.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/18.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public protocol AttributedStringMergeStyle {
    typealias Style = AttributedStringStyle
    associatedtype AttrString: _AttributedString
    func mergeStyle(_ style: Style..., range: NSRange?) -> AttrString
    func mergeStyle(_ style: [Style], range: NSRange?) -> AttrString
}
public extension AttributedStringMergeStyle {
    @inline(__always)
    func mergeStyle(_ style: Style..., range: NSRange? = nil) -> AttrString {
        mergeStyle(style, range: range)
    }
}
extension AttributedString: AttributedStringMergeStyle {
    @inline(__always)
    public func mergeStyle(_ style: [Style], range: NSRange? = nil) -> Self {
        var result = self
        let range = range ?? defaultRange
        let style = style.reduce(into: Style(), {$0.merge($1)})
        result.setAttributes(style.attributes, range: range)
        return result
    }
}
public extension AttributedStringCreater where Self: AttributedStringMergeStyle {
    @inline(__always)
    func mergeStyle(_ style: [Style], range: NSRange? = nil) -> AttributedString {
        AttributedString(self).mergeStyle(style, range: range)
    }
}
extension String: AttributedStringMergeStyle {}
extension UIImage: AttributedStringMergeStyle {}
extension NSTextAttachment: AttributedStringMergeStyle {}
extension NSAttributedString: AttributedStringMergeStyle {}
