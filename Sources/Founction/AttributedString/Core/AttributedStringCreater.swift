//
//  AttributedStringCreater.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public protocol AttributedStringCreater {
    ///创建一个可变字符串
    @inline(__always)
    func createMutableAttributedString() -> NSMutableAttributedString
    ///获取属性字符串，如果当前已经是属性字符串(无论是否可变) 则直接返回
    @inline(__always)
    func unsafeGetAttributedString() -> NSAttributedString
}
public extension AttributedStringCreater {
    @inline(__always)
    func unsafeGetAttributedString() -> NSAttributedString {
        return createMutableAttributedString()
    }
}
extension String: AttributedStringCreater {
    @inline(__always)
    public func createMutableAttributedString() -> NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}
extension UIImage: AttributedStringCreater {
    @inline(__always)
    public func createMutableAttributedString() -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = self
        return attachment.createMutableAttributedString()
    }
}
extension NSTextAttachment: AttributedStringCreater {
    @inline(__always)
    public func createMutableAttributedString() -> NSMutableAttributedString {
        NSMutableAttributedString(attachment: self)
    }
}
extension NSAttributedString: AttributedStringCreater {
    @inline(__always)
    public func createMutableAttributedString() -> NSMutableAttributedString {
        // swiftlint:disable force_cast
        return self.mutableCopy() as! NSMutableAttributedString
    }
    @inline(__always)
    public func unsafeGetAttributedString() -> NSAttributedString {
        self
    }
}
public extension _AttributedString where Self: AttributedStringCreater {
    @inline(__always)
    func createMutableAttributedString() -> NSMutableAttributedString {
        self._value.createMutableAttributedString()
    }
    @inline(__always)
    func unsafeGetAttributedString() -> NSAttributedString {
        self._value.unsafeGetAttributedString()
    }
}
