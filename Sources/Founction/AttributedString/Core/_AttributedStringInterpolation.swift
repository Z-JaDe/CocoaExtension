//
//  _AttributedStringInterpolation.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public func createAttrStr(_ closure: () -> AttributedString) -> NSAttributedString {
    closure().finalize()
}

extension AttributedString: ExpressibleByStringInterpolation {
    public init(stringInterpolation: AttributedStringInterpolation) {
        self.init(stringInterpolation.value)
    }
}

public struct AttributedStringInterpolation: StringInterpolationProtocol {
    public typealias Style = AttributedStringStyle
    let value: AttributedStringClass

    public init(literalCapacity: Int, interpolationCount: Int) {
        self.value = AttributedStringClass()
    }
    public func appendLiteral(_ literal: String) {
        self.value.append(literal)
    }
    public func appendInterpolation(_ string: String, attributes: [NSAttributedString.Key: Any]) {
        let astr = NSAttributedString(string: string, attributes: attributes)
        self.value.append(astr)
    }
}
extension AttributedStringInterpolation {
    public func appendInterpolation(_ string: String, _ style: Style...) {
        self.value.append(string.mergeStyle(style))
    }
    public func appendInterpolation(image: UIImage, scale: CGFloat = 1.0) {
        self.value.append(image.scaleTo(scale))
    }
    public func appendInterpolation(wrap string: AttributedString) {
        self.value.append(string)
    }
}
