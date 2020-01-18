//
//  AttributedStringClass.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/18.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public final class AttributedStringClass: _AttributedString {
    public typealias V = NSMutableAttributedString
    public let _value: V
    public init() {
        self._value = V()
    }
    public init<T: AttributedStringCreater>(_ value: T?) {
        guard let value = value else {
            self._value = V()
            return
        }
        self._value = value.createMutableAttributedString()
    }
    public func append<T: AttributedStringCreater>(_ value: T) {
        self._value.append(value.unsafeGetAttributedString())
    }
    public func copy() -> Self {
        return Self(self._value)
    }
}
