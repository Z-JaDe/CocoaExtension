//
//  UIEdgeInsets.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//

import Foundation

public extension UIEdgeInsets {
    var horizontal: CGFloat {
        left + right
    }
    var vertical: CGFloat {
        top + bottom
    }
}
