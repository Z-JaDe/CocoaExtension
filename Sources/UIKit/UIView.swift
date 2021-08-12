//
//  UIView.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
public extension UIView {
    convenience init(backgroundColor: UIColor, alpha: CGFloat = 1) {
        self.init()
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
}
public extension UIView {
//    public func addTitleShadow(scale: Float = 1) {
//        self.addShadow(offset: CGSize(width: 0, height: 0), color: UIColor.black, opacity: 0.3 * scale, radius: 5)
//    }
//    public func addButtonShadow(color: UIColor = UIColor.black) {
//        self.addShadow(offset: CGSize(width: 0, height: 0), color: color, opacity: 0.5, radius: 5)
//    }
    func addShadow(offset: CGSize, color: UIColor, opacity: Float, radius: CGFloat) {
        self.layer.addShadow(offset: offset, color: color, opacity: opacity, radius: radius)
    }
}
public extension CALayer {
    func addShadow(offset: CGSize, color: UIColor, opacity: Float, radius: CGFloat) {
        self.shadowColor = color.cgColor
        self.shadowOpacity = opacity

        self.shadowOffset = offset
        self.shadowRadius = radius
    }
}
public extension UIView {
    func removeAllSubviews() {
        for subview in subviews {
            if let stackView = self as? UIStackView {
                stackView.removeArrangedSubview(subview)
            }
            subview.removeFromSuperview()
        }
    }
}

public extension UIView {
    /// 根据宽度 计算高度 自动布局
    func calculateAutoLayoutHeight(_ targetWidth: CGFloat) -> CGFloat {
        return calculateAutoLayoutHeight(CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: UILayoutPriority(rawValue: 999.1)).height
    }
    /// 根据尺寸 计算高度 自动布局
    func calculateAutoLayoutHeight(_ targetSize: CGSize,
                                   withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority = .fittingSizeLevel,
                                   verticalFittingPriority: UILayoutPriority = .fittingSizeLevel) -> CGSize {
        let _translates = self.translatesAutoresizingMaskIntoConstraints
        self.translatesAutoresizingMaskIntoConstraints = false
        defer {
            self.translatesAutoresizingMaskIntoConstraints = _translates
        }
        return systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
    }
}
// MARK: Layer Extensions

public extension UIView {
    var backgroundColorAlpha: CGFloat {
        get {
            var a: CGFloat = 0
            self.backgroundColor?.getRed(nil, green: nil, blue: nil, alpha: &a)
            return a
        }
        set {
            self.backgroundColor = self.backgroundColor?.alpha(newValue)
        }
    }

    func addBorder(width: CGFloat = jd.onePx, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

extension UIView {
    /// ZJaDe:  [.topLeft, .topRight]
    @objc open func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    @objc open func roundView() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2
    }
    public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}

public extension UIView {
    func rootView() -> UIView {
        if let superview = self.superview {
            return superview.rootView()
        } else {
            return self
        }
    }
    func superView<T: UIView>(_ viewType: T.Type) -> T? {
       var temp: UIView? = self
        repeat {
            if let _temp = temp as? T {
                return _temp
            }
            temp = temp?.superview
        } while (temp != nil)
        return nil
    }
    func viewController<T: UIViewController>(_ vcType: T.Type) -> T? {
        return responder(vcType)
    }
    private func responder<T: UIResponder>(_ type: T.Type) -> T? {
        var temp: UIResponder? = self
        repeat {
            if let _temp = temp as? T {
                return _temp
            }
            temp = temp?.next
        } while (temp != nil)
        return nil
    }
    func navItemVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        guard var viewCon = self.viewController(UIViewController.self) else {
            return nil
        }
        guard let navC = viewCon.navigationController else {
            return nil
        }
        while let parentVC = viewCon.parent {
            if parentVC == navC {
                return viewCon as? T
            } else if parentVC == viewCon.tabBarController {
                return viewCon as? T
            }
            viewCon = parentVC
        }
        return nil
    }
}
public extension UIView {
    func searchVisualEffectsSubview() -> UIVisualEffectView? {
        if let visualEffectView = self as? UIVisualEffectView {
            return visualEffectView
        } else {
            for subview in subviews {
                if let found = subview.searchVisualEffectsSubview() {
                    return found
                }
            }
        }
        return nil
    }
    func subViews<T: UIView>(type: T.Type) -> [T] {
        return subviews.compactMap({$0 as? T})
    }
    func allSubViewsOf<T: UIView>(type: T.Type) -> [T] {
        if let temp = self as? T {
            return CollectionOfOne(temp) + subviews.flatMap({$0.allSubViewsOf(type: T.self)})
        } else {
            return subviews.flatMap({$0.allSubViewsOf(type: T.self)})
        }
    }
}
