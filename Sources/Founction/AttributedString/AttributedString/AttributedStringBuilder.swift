//
//  AttributedStringBuilder.swift
//  AppExtension
//
//  Created by ZJaDe on 2018/7/22.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import Foundation

@resultBuilder
struct AttributedStringBuilder<Element: AttributedStringAppendable & AttributedStringCreater> {
    static func buildBlock(_ content: Element...) -> Element {
        content.reduce(into: Element()) { (result, attrStr) in
            result.append(attrStr)
        }
    }
    static func buildIf(_ content: Element?) -> Element {
        content ?? Element()
    }
    static func buildEither(first: Element) -> Element {
        first
    }
    static func buildEither(second: Element) -> Element {
        second
    }
}

//extension UILabel {
//    func makeAttrStr(@AttributedStringBuilder<AttributedStringClass> content: () -> AttributedStringClass) {
//        self.attributedText = content().finalize()
//    }
//}
//extension NSAttributedString {
//    static func build(@AttributedStringBuilder<AttributedStringClass> content: () -> AttributedStringClass) -> NSAttributedString {
//        content().finalize()
//    }
//}
//extension AttributedString {
//    static func build(@AttributedStringBuilder<AttributedStringClass> content: () -> AttributedStringClass) -> AttributedString {
//        AttributedString(value: content())
//    }
//}
