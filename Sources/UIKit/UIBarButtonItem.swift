//
//  UIBarButtonItem.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

// MARK: - Properties
public extension UIBarButtonItem {
    static var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
}

// MARK: - Methods
public extension UIBarButtonItem {
    func addTargetForAction(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }

    static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = width
        return barButtonItem
    }
}
