//
//  _AttributedStringInterpolation.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

extension AttributedString: ExpressibleByStringInterpolation {
    public init(stringInterpolation: _AttributedStringInterpolation) {
        self.init(stringInterpolation.value)
    }
}

public struct _AttributedStringInterpolation: StringInterpolationProtocol {
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
extension _AttributedStringInterpolation {
    public func appendInterpolation(_ string: String, _ style: Style...) {
        self.value.append(AttributedString(string).map(style))
    }
}
extension _AttributedStringInterpolation {
    public func appendInterpolation(image: UIImage, scale: CGFloat = 1.0) {
        self.value.append(image.scaleTo(scale))
    }
}
extension _AttributedStringInterpolation {
    func appendInterpolation(wrap string: AttributedString, _ style: Style...) {
        self.value.append(string.map(style))
    }
}
