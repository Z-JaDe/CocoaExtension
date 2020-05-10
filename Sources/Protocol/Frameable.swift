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
public extension Frameable {
    @inline(__always)
    var origin: CGPoint {
        get { frame.origin }
        set { frame.origin = newValue }
    }
    @inline(__always)
    var size: CGSize {
        get { frame.size }
        set { frame.size = newValue }
    }
}
public extension Frameable {
    @inline(__always)
    var width: CGFloat {
        get { size.width }
        set { size.width = newValue }
    }
    @inline(__always)
    var height: CGFloat {
        get { size.height }
        set { size.height = newValue }
    }

    @inline(__always)
    var x: CGFloat {
        get { origin.x }
        set { origin.x = newValue }
    }
    @inline(__always)
    var y: CGFloat {
        get { origin.y }
        set { origin.y = newValue }
    }

    @inline(__always)
    var innerCenter: CGPoint {
        CGPoint(x: width / 2, y: height / 2)
    }
}
public extension Frameable {
    @inline(__always)
    var top: CGFloat {
        get { y }
        set { y = newValue }
    }
    @inline(__always)
    var left: CGFloat {
        get { x }
        set { x = newValue }
    }
    @inline(__always)
    var bottom: CGFloat {
        get { top + height }
        set { top = newValue - height }
    }
    @inline(__always)
    var right: CGFloat {
        get { left + width }
        set { left = newValue - width }
    }
}
// MARK: - center
public extension Frameable where Self: UIView {
    @inline(__always)
    var centerX: CGFloat {
        get { center.x }
        set { center.x = newValue }
    }
    @inline(__always)
    var centerY: CGFloat {
        get { center.y }
        set { center.y = newValue }
    }
}
extension UIView: Frameable {}
extension CALayer: Frameable {}
