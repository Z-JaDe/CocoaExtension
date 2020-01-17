//
//  AttributedStringMakerProtocol.swift
//  AppExtension
//
//  Created by Apple on 2019/10/14.
//  Copyright © 2019 ZJaDe. All rights reserved.
//

import Foundation

public protocol AttributedStringMakerProtocol {
    func createMaker() -> AttributedStringMaker
}
extension AttributedStringMaker: AttributedStringMakerProtocol {
    public func createMaker() -> AttributedStringMaker {
        return self
    }
}
extension String: AttributedStringMakerProtocol {
    public func createMaker() -> AttributedStringMaker {
        AttributedStringMaker(self)
    }
}
extension NSAttributedString: AttributedStringMakerProtocol {
    public func createMaker() -> AttributedStringMaker {
        AttributedStringMaker(self)
    }
}
// MARK: -
public extension AttributedStringMakerProtocol {
    func setAttribute(_ key: NSAttributedString.Key, value: Any?, range: NSRange?) -> AttributedStringMaker {
        createMaker()._setAttribute(key, value: value, range: range)
    }
    func paragraphStyle(_ style: NSParagraphStyle?, range: NSRange? = nil) -> AttributedStringMaker {
        createMaker()._paragraphStyle(style, range: range)
    }
}
public extension AttributedStringMakerProtocol {
}
