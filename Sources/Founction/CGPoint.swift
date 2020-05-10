//
//  CGPoint.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//

import Foundation

// MARK: - Methods
public extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + dx, y: self.y + dy)
    }
    func distance(from point: CGPoint) -> CGFloat {
        return CGPoint.distance(from: self, to: point)
    }
    static func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
}

// MARK: - Operators
public extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        // swiftlint:disable:next shorthand_operator
        lhs = lhs + rhs
    }

    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        // swiftlint:disable:next shorthand_operator
        lhs = lhs - rhs
    }

    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    static func *= (point: inout CGPoint, scalar: CGFloat) {
        // swiftlint:disable:next shorthand_operator
        point = point * scalar
    }
    static func * (scalar: CGFloat, point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

}
