//
//  UIView+ContentPriority.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

public extension UIView {
    func contentPriority(_ priority: UILayoutPriority) {
        self.contentHuggingPriority(priority)
        self.contentCompressionResistancePriority(priority)
    }
    func contentVerticalPriority(_ priority: UILayoutPriority) {
        self.contentHuggingVerticalPriority = priority
        self.contentCompressionResistanceVerticalPriority = priority
    }
    func contentHorizontalPriority(_ priority: UILayoutPriority) {
        self.contentCompressionResistanceHorizontalPriority = priority
        self.contentHuggingHorizontalPriority = priority
    }
    func contentHuggingPriority(_ priority: UILayoutPriority) {
        self.contentHuggingVerticalPriority = priority
        self.contentHuggingHorizontalPriority = priority
    }
    func contentCompressionResistancePriority(_ priority: UILayoutPriority) {
        self.contentCompressionResistanceHorizontalPriority = priority
        self.contentCompressionResistanceVerticalPriority = priority
    }
    // MARK: -
    var contentHuggingHorizontalPriority: UILayoutPriority {
        get { self.contentHuggingPriority(for: .horizontal) }
        set { self.setContentHuggingPriority(newValue, for: .horizontal) }
    }
    var contentHuggingVerticalPriority: UILayoutPriority {
        get { self.contentHuggingPriority(for: .vertical) }
        set { self.setContentHuggingPriority(newValue, for: .vertical) }
    }
    var contentCompressionResistanceHorizontalPriority: UILayoutPriority {
        get { self.contentCompressionResistancePriority(for: .horizontal) }
        set { self.setContentCompressionResistancePriority(newValue, for: .horizontal) }
    }
    var contentCompressionResistanceVerticalPriority: UILayoutPriority {
        get { self.contentCompressionResistancePriority(for: .vertical) }
        set { self.setContentCompressionResistancePriority(newValue, for: .vertical) }
    }
}
