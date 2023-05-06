//
//  CGSize.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//

import Foundation

// MARK: - Methods
public extension CGSize {
    var aspectRatio: CGFloat {
        return height == 0 ? 0 : width / height
    }
    var maxDimension: CGFloat {
        return max(width, height)
    }
    var minDimension: CGFloat {
        return min(width, height)
    }
}

// MARK: - Methods
public extension CGSize {
    func scaleAspectFit(to boundingSize: CGSize) -> CGSize {
        let minRatio = min(boundingSize.width / width, boundingSize.height / height)
        return CGSize(width: width * minRatio, height: height * minRatio)
    }
    func scaleAspectFill(to boundingSize: CGSize) -> CGSize {
        let minRatio = max(boundingSize.width / width, boundingSize.height / height)
        let aWidth = min(width * minRatio, boundingSize.width)
        let aHeight = min(height * minRatio, boundingSize.height)
        return CGSize(width: aWidth, height: aHeight)
    }

}
// MARK: - Operators
public extension CGSize {
    static func + (left: CGSize, right: UIEdgeInsets) -> CGSize {
        var left = left
        left.width += right.horizontal
        left.height += right.vertical
        return left
    }
    static func += (left: inout CGSize, right: UIEdgeInsets) {
        // swiftlint:disable shorthand_operator
        left = left + right
    }
    static func - (left: CGSize, right: UIEdgeInsets) -> CGSize {
        var left = left
        left.width -= right.horizontal
        left.height -= right.vertical
        return left
    }
    static func -= (left: inout CGSize, right: UIEdgeInsets) {
        // swiftlint:disable shorthand_operator
        left = left - right
    }
    static func + (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width + right.width, height: left.height + right.height)
    }
    static func += (left: inout CGSize, right: CGSize) {
        left = CGSize(width: left.width + right.width, height: left.height + right.height)
    }
}
