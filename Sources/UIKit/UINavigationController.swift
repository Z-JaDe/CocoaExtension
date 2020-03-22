//
//  UINavigationController.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/19.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

extension UINavigationController {
    @discardableResult
    public func popTo<T: UIViewController>(_ VCType: T.Type, animated: Bool) -> Bool {
        if let viewCon = self.viewControllers.first(where: {$0 is T}) {
            self.popToViewController(viewCon, animated: animated)
            return true
        } else {
            return false
        }
    }
    public func pop(count: Int, animated: Bool) {
        if count <= 0 { return }
        let viewConArr = self.viewControllers.dropLast(count)
        if viewConArr.isEmpty {
            // 只保留根控制器，如果本来就只有1个根控制器则不需要设置
            if let first = self.viewControllers.first, self.viewControllers.count > 1 {
                self.setViewControllers([first], animated: animated)
            }
        } else {
            self.setViewControllers(Array(viewConArr), animated: animated)
        }
    }
    public func popAndPush(count: Int, pushVC: UIViewController, animated: Bool) {
        if count <= 0 {
            self.pushViewController(pushVC, animated: animated)
        } else {
            var viewConArr: [UIViewController] = self.viewControllers.dropLast(count)
            viewConArr.append(pushVC)
            self.setViewControllers(viewConArr, animated: animated)
        }
    }
}
