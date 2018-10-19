//
//  UIScrollView.swift
//  SNKit
//
//  Created by 郑军铎 on 2018/5/28.
//  Copyright © 2018年 syk. All rights reserved.
//

import UIKit

extension UIScrollView {
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
