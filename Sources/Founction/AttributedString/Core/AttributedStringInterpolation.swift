//
//  AttributedStringInterpolation.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

extension AttributedString: ExpressibleByStringInterpolation {
    public init(stringInterpolation: AttributedStringInterpolation) {
        self.init(value: stringInterpolation.value)
    }
}

public struct AttributedStringInterpolation: StringInterpolationProtocol {
    let value: AttributedStringClass

    public init(literalCapacity: Int, interpolationCount: Int) {
        self.value = AttributedStringClass()
    }
    public func appendLiteral(_ literal: String) {
        self.value.append(literal)
    }
    public func appendInterpolation(_ string: String, attributes: [NSAttributedString.Key: Any]) {
        self.value.append(NSAttributedString(string: string, attributes: attributes))
    }
}
public extension AttributedStringInterpolation {
    func appendInterpolation(image: UIImage, scale: CGFloat = 1.0) {
        self.value.append(image.scaleTo(scale))
    }
    func appendInterpolation(wrap string: AttributedString) {
        self.value.append(string)
    }
}
