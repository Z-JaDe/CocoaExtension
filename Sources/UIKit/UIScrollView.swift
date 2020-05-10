//
//  UIScrollView.swift
//  SNKit
//
//  Created by ZJaDe on 2018/5/28.
//  Copyright © 2018年 syk. All rights reserved.
//

import UIKit

public extension UIScrollView {
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    var snapshot: UIImage? {
        // Original Source: https://gist.github.com/thestoics/1204051
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
