//
//  AttributedStringMaker.swift
//  AppExtension
//
//  Created by ZJaDe on 2018/7/22.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import Foundation
// TODO: AttributedStringMaker 与 Style 结合模仿SwiftUI封装
//为了防止链式写法不断写时拷贝，使用class
public class AttributedStringMaker {
    var attrStr: AttributedString
    init(_ value: AttributedString) {
        self.attrStr = value
    }
    init(_ value: String = "") {
        self.attrStr = AttributedString(value)
    }
    init(_ value: NSAttributedString?) {
        self.attrStr = AttributedString(value)
    }
    public func finalize() -> NSAttributedString {
        self.attrStr.finalize()
    }
    fileprivate var defaultRange: NSRange {
        self.attrStr.defaultRange
    }
}
extension AttributedStringMaker {
    public var string: String {
        self.attrStr.string
    }
}
extension AttributedStringMaker {
    public func then(_ closure: (AttributedStringMaker) -> Void) -> Self {
        closure(self)
        return self
    }
    @discardableResult
    func _setAttribute(_ key: NSAttributedString.Key, value: Any?, range: NSRange?) -> Self {
        self.attrStr.setAttribute(key, value: value, range: range)
        return self
    }
    @discardableResult
    func _paragraphStyle(_ style: NSParagraphStyle?, range: NSRange? = nil) -> Self {
        self.attrStr.setAttribute(.paragraphStyle, value: style, range: range)
        return self
    }
    @discardableResult
    func _setParagraphStyleAttr<T: Equatable>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, value: T, range: NSRange?) -> Self {
        self.attrStr.paragraphStyleKeyPath(keyPath, value: value, range: range)
        return self
    }
}

extension AttributedStringMaker {
    /// 属性字符串拼接还是需要重新生成一个AttributedStringMaker
    public static func + (left: AttributedStringMaker, right: AttributedStringMakerProtocol) -> AttributedStringMaker {
        var attrStr = left.attrStr
        attrStr.append(right.createMaker().attrStr)
        return AttributedStringMaker(attrStr)
    }
    /// 属性字符串拼接还是需要重新生成一个AttributedStringMaker
    public static func += (left: inout AttributedStringMaker, right: AttributedStringMakerProtocol) {
        // swiftlint:disable shorthand_operator
        left = left + right
    }
}
