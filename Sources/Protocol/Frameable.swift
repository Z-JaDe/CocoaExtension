//
//  Frameable.swift
//  Third
//
//  Created by ZJaDe on 2018/6/15.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit

public protocol Frameable: class {
    var frame: CGRect {get set}
    var bounds: CGRect {get set}
}
extension Frameable {
    @inlinable
    public var origin: CGPoint {
        get { frame.origin }
        set { frame.origin = newValue }
    }
    @inlinable
    public var size: CGSize {
        get { frame.size }
        set { frame.size = newValue }
    }
}
extension Frameable {
    @inlinable
    public var width: CGFloat {
        get { size.width }
        set { size.width = newValue }
    }
    @inlinable
    public var height: CGFloat {
        get { size.height }
        set { size.height = newValue }
    }

    @inlinable
    public var x: CGFloat {
        get { origin.x }
        set { origin.x = newValue }
    }
    @inlinable
    public var y: CGFloat {
        get { origin.y }
        set { origin.y = newValue }
    }

    @inlinable
    public var innerCenter: CGPoint {
        CGPoint(x: width / 2, y: height / 2)
    }
}
extension Frameable {
    @inlinable
    public var top: CGFloat {
        get { y }
        set { y = newValue }
    }
    @inlinable
    public var left: CGFloat {
        get { x }
        set { x = newValue }
    }
    @inlinable
    public var bottom: CGFloat {
        get { top + height }
        set { top = newValue - height }
    }
    @inlinable
    public var right: CGFloat {
        get { left + width }
        set { left = newValue - width }
    }
}
// MARK: - center
extension Frameable where Self: UIView {
    @inlinable
    public var centerX: CGFloat {
        get { center.x }
        set { center.x = newValue }
    }
    @inlinable
    public var centerY: CGFloat {
        get { center.y }
        set { center.y = newValue }
    }
}
extension UIView: Frameable {}
extension CALayer: Frameable {}
