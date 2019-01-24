//
//  UIView+ContentPriority.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

extension UIView {
    public func contentPriority(_ priority: UILayoutPriority) {
        self.contentHuggingPriority(priority)
        self.contentCompressionResistancePriority(priority)
    }
    public func contentVerticalPriority(_ priority: UILayoutPriority) {
        self.contentHuggingVerticalPriority = priority
        self.contentCompressionResistanceVerticalPriority = priority
    }
    public func contentHorizontalPriority(_ priority: UILayoutPriority) {
        self.contentCompressionResistanceHorizontalPriority = priority
        self.contentHuggingHorizontalPriority = priority
    }
    public func contentHuggingPriority(_ priority: UILayoutPriority) {
        self.contentHuggingVerticalPriority = priority
        self.contentHuggingHorizontalPriority = priority
    }
    public func contentCompressionResistancePriority(_ priority: UILayoutPriority) {
        self.contentCompressionResistanceHorizontalPriority = priority
        self.contentCompressionResistanceVerticalPriority = priority
    }
    // MARK: -
    public var contentHuggingHorizontalPriority: UILayoutPriority {
        get { return self.contentHuggingPriority(for: .horizontal) }
        set { self.setContentHuggingPriority(newValue, for: .horizontal) }
    }
    public var contentHuggingVerticalPriority: UILayoutPriority {
        get { return self.contentHuggingPriority(for: .vertical) }
        set { self.setContentHuggingPriority(newValue, for: .vertical) }
    }
    public var contentCompressionResistanceHorizontalPriority: UILayoutPriority {
        get { return self.contentCompressionResistancePriority(for: .horizontal) }
        set { self.setContentCompressionResistancePriority(newValue, for: .horizontal) }
    }
    public var contentCompressionResistanceVerticalPriority: UILayoutPriority {
        get { return self.contentCompressionResistancePriority(for: .vertical) }
        set { self.setContentCompressionResistancePriority(newValue, for: .vertical) }
    }
}
