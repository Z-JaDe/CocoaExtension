//
//  AttributedStringBuilder.swift
//  AppExtension
//
//  Created by ZJaDe on 2018/7/22.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import Foundation
// TODO: 属性字符串 Builder
extension AttributedString {
    @_functionBuilder
    public struct Builder<Element: _AttributedString> {
        public static func buildBlock(_ content: Element...) -> Element {
            content.reduce(into: Element()) { (result, attrStr) in
                result.append(attrStr.appending("\n"))
            }
        }
        public static func buildIf(_ content: Element?) -> Element {
            content ?? Element()
        }
        public static func buildEither(first: Element) -> Element {
            first
        }
        public static func buildEither(second: Element) -> Element {
            second
        }
    }
}

public func makeAttrStr(@AttributedString.Builder<AttributedString> content: () -> AttributedString) -> NSAttributedString {
    content().finalize()
}
extension UILabel {
    public func makeAttrStr(@AttributedString.Builder<AttributedString> content: () -> AttributedString) {
        self.attributedText = content().finalize()
    }
}
