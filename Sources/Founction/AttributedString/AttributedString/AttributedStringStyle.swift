//
//  AttributedStringStyle.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public struct AttributedStringStyle {
    let attributes: [NSAttributedString.Key: Any]
}
public extension AttributedStringStyle {
    init(_ attributes: [NSAttributedString.Key: Any] = [:]) {
        self.attributes = attributes
    }
    init<V>(key: NSAttributedString.Key, value: V) {
        self.attributes = [key: value]
    }
}
public extension AttributedStringStyle {
    @inline(__always)
    mutating func merge<V>(_ attributes: [NSAttributedString.Key: V]) {
        self = Self(self.attributes.merging(attributes, uniquingKeysWith: {$1}))
    }
    @inline(__always)
    mutating func merge(_ style: Self) {
        merge(style.attributes)
    }
    @inline(__always)
    mutating func merge<V>(key: NSAttributedString.Key, value: V) {
        merge([key: value])
    }
}
public extension AttributedStringStyle {
    @inline(__always)
    func merging<V>(_ attributes: [NSAttributedString.Key: V]) -> Self {
        Self(self.attributes.merging(attributes, uniquingKeysWith: {$1}))
    }
    @inline(__always)
    func merging(_ style: Self) -> Self {
        merging(style.attributes)
    }
    @inline(__always)
    func merging<V>(key: NSAttributedString.Key, value: V) -> Self {
        merging([key: value])
    }
}
