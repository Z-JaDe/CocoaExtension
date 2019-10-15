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
        var vcArr = self.viewControllers
        vcArr.removeLast(count)
        self.setViewControllers(vcArr, animated: animated)
    }
    public func popAndPush(count: Int, pushVC: UIViewController, animated: Bool) {
        var vcArr = self.viewControllers
        vcArr.removeLast(count)
        vcArr.append(pushVC)
        self.setViewControllers(vcArr, animated: animated)
    }
}
