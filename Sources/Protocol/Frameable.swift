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
    public var origin: CGPoint {
        get {return self.frame.origin}
        set {self.frame.origin = newValue}
    }
    public var size: CGSize {
        get {return self.frame.size}
        set {self.frame.size = newValue}
    }
}
extension Frameable {
    public var width: CGFloat {
        get {return self.size.width}
        set {self.size.width = newValue}
    }
    public var height: CGFloat {
        get {return self.size.height}
        set {self.size.height = newValue}
    }

    public var x: CGFloat {
        get {return self.origin.x}
        set {self.origin.x = newValue}
    }
    public var y: CGFloat {
        get {return self.origin.y}
        set {self.origin.y = newValue}
    }
}
extension Frameable {
    public var top: CGFloat {
        get {return self.y}
        set {self.y = newValue}
    }
    public var left: CGFloat {
        get {return self.x}
        set {self.x = newValue}
    }
    public var bottom: CGFloat {
        get {return self.top + self.height}
        set {self.top = newValue - self.height}
    }
    public var right: CGFloat {
        get {return self.left + self.width}
        set {self.left = newValue - self.width}
    }
}
// MARK: - center
extension Frameable where Self: UIView {
//    public var center: CGPoint {
//        get {return CGPoint(x: self.left + self.width / 2, y: self.top + self.height / 2)}
//        set {
//            self.left = newValue.x - self.width / 2
//            self.top = newValue.y - self.height / 2
//        }
//    }
    public var centerX: CGFloat {
        get {return self.center.x}
        set {self.center.x = newValue}
    }
    public var centerY: CGFloat {
        get {return self.center.y}
        set {self.center.y = newValue}
    }
}
extension UIView: Frameable {}
extension CALayer: Frameable {}
