//
//  Frameable.swift
//  Third
//
//  Created by ZJaDe on 2018/6/15.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit

public protocol Frameable: AnyObject {
    var frame: CGRect {get set}
    var bounds: CGRect {get set}
}
public extension Frameable {
    var origin: CGPoint {
        get { frame.origin }
        set { frame.origin = newValue }
    }
    var size: CGSize {
        get { frame.size }
        set { frame.size = newValue }
    }
}
public extension Frameable {
    var width: CGFloat {
        get { size.width }
        set { size.width = newValue }
    }
    var height: CGFloat {
        get { size.height }
        set { size.height = newValue }
    }

    var x: CGFloat {
        get { origin.x }
        set { origin.x = newValue }
    }
    var y: CGFloat {
        get { origin.y }
        set { origin.y = newValue }
    }

    var innerCenter: CGPoint {
        CGPoint(x: width / 2, y: height / 2)
    }
}
public extension Frameable {
    var top: CGFloat {
        get { y }
        set { y = newValue }
    }
    var left: CGFloat {
        get { x }
        set { x = newValue }
    }
    var bottom: CGFloat {
        get { top + height }
        set { top = newValue - height }
    }
    var right: CGFloat {
        get { left + width }
        set { left = newValue - width }
    }
}
// MARK: - center
public extension Frameable where Self: UIView {
    var centerX: CGFloat {
        get { center.x }
        set { center.x = newValue }
    }
    var centerY: CGFloat {
        get { center.y }
        set { center.y = newValue }
    }
}
extension UIView: Frameable {}
extension CALayer: Frameable {}
