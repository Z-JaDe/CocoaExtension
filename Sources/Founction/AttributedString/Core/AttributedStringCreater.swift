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
    func createMutableAttributedString() -> NSMutableAttributedString
    ///获取属性字符串，如果当前已经是属性字符串(无论是否可变) 则直接返回
    func unsafeGetAttributedString() -> NSAttributedString
}
public extension AttributedStringCreater {
    func unsafeGetAttributedString() -> NSAttributedString {
        return createMutableAttributedString()
    }
}
extension NSTextAttachment: AttributedStringCreater {
    public func createMutableAttributedString() -> NSMutableAttributedString {
        NSMutableAttributedString(attachment: self)
    }
}
extension String: AttributedStringCreater {
    public func createMutableAttributedString() -> NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}
extension UIImage: AttributedStringCreater {
    public func createMutableAttributedString() -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = self
        return attachment.createMutableAttributedString()
    }
}
extension NSAttributedString: AttributedStringCreater {
    public func createMutableAttributedString() -> NSMutableAttributedString {
        // swiftlint:disable force_cast
        return self.mutableCopy() as! NSMutableAttributedString
    }
    public func unsafeGetAttributedString() -> NSAttributedString {
        self
    }
}
