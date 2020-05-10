//
//  CGVector.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

#if canImport(CoreGraphics)
import CoreGraphics

// MARK: - Properties
public extension CGVector {
    /// https://en.wikipedia.org/wiki/Atan2
    var angle: CGFloat {
        return atan2(dy, dx)
    }

    /// https://en.wikipedia.org/wiki/Euclidean_vector#Length
    var magnitude: CGFloat {
        return sqrt((dx * dx) + (dy * dy))
    }

}

// MARK: - Initializers
public extension CGVector {
    init(angle: CGFloat, magnitude: CGFloat) {
        // https://www.grc.nasa.gov/WWW/K-12/airplane/vectpart.html
        self.init(dx: magnitude * cos(angle), dy: magnitude * sin(angle))
    }

}

// MARK: - Operators
public extension CGVector {
    static func * (vector: CGVector, scalar: CGFloat) -> CGVector {
        return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }
    static func * (scalar: CGFloat, vector: CGVector) -> CGVector {
        return CGVector(dx: scalar * vector.dx, dy: scalar * vector.dy)
    }
    static func *= (vector: inout CGVector, scalar: CGFloat) {
        // swiftlint:disable:next shorthand_operator
        vector = vector * scalar
    }

    static prefix func - (vector: CGVector) -> CGVector {
        return CGVector(dx: -vector.dx, dy: -vector.dy)
    }

}

#endif
