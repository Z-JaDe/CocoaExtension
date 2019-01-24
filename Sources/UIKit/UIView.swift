//
//  UIView.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
extension UIView {
    public convenience init(backgroundColor: UIColor, alpha: CGFloat = 1) {
        self.init()
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
}
extension UIView {
//    public func addTitleShadow(scale: Float = 1) {
//        self.addShadow(offset: CGSize(width: 0, height: 0), color: UIColor.black, opacity: 0.3 * scale, radius: 5)
//    }
//    public func addButtonShadow(color: UIColor = UIColor.black) {
//        self.addShadow(offset: CGSize(width: 0, height: 0), color: color, opacity: 0.5, radius: 5)
//    }
    public func addShadow(offset: CGSize, color: UIColor, opacity: Float, radius: CGFloat) {
        self.layer.addShadow(offset: offset, color: color, opacity: opacity, radius: radius)
    }
}
extension CALayer {
    public func addShadow(offset: CGSize, color: UIColor, opacity: Float, radius: CGFloat) {
        self.shadowColor = color.cgColor
        self.shadowOpacity = opacity

        self.shadowOffset = offset
        self.shadowRadius = radius
    }
}
extension UIView {
    public func removeAllSubviews() {
        for subview in subviews {
            if let stackView = self as? UIStackView {
                stackView.removeArrangedSubview(subview)
            }
            subview.removeFromSuperview()
        }
    }
}
extension UIView {
    public func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.width
                let newHeight = aView.y + aView.height
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }
    public func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    someView.top = currentHeight
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }
}
// MARK: Layer Extensions
extension UIView {
    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    public var backgroundColorAlpha: CGFloat {
        get {
            var a: CGFloat = 0
            self.backgroundColor?.getRed(nil, green: nil, blue: nil, alpha: &a)
            return a
        }
        set {
            self.backgroundColor = self.backgroundColor?.alpha(newValue)
        }
    }

    public func addBorder(width: CGFloat = jd.onePx, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

extension UIView {
    /// ZJaDe:  [.topLeft, .topRight]
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    public var cornerRadius: CGFloat {
        get {return self.layer.cornerRadius}
        set {self.layer.cornerRadius = newValue}
    }
    @objc open func roundView() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2
    }
}

extension UIView {
    public func rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.rootView()
    }
    public func superView<T: UIView>(_ viewType: T.Type) -> T? {
        var responder: UIResponder? = self
        repeat {
            if responder is T {
                return responder as? T
            }
            responder = responder?.next
        }while (responder != nil)
        return nil
    }
    public func viewController<T: UIViewController>(_ vcType: T.Type) -> T? {
        var responder: UIResponder? = self
        repeat {
            if responder is T {
                return responder as? T
            }
            responder = responder?.next
        }while (responder != nil)
        return nil
    }
    public func navItemVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        guard var viewCon = self.viewController(UIViewController.self) else {
            return nil
        }
        guard let navC = viewCon.navigationController else {
            return nil
        }
        repeat {
            guard let parentVC = viewCon.parent else {
                return nil
            }
            if parentVC == navC {
                return viewCon as? T
            } else if parentVC == viewCon.tabBarController {
                return viewCon as? T
            }
            viewCon = parentVC
        } while (viewCon.parent != nil)
        return nil
    }
}
