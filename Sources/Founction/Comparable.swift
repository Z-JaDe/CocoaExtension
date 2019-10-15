//
//  Comparable.swift
//  AppExtension
//
//  Created by ZJaDe on 2018/6/25.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import Foundation

extension Comparable {
    /// ZJaDe: 找到3个数中间的那个
    public func clamp(min: Self, max: Self) -> Self {
        return Swift.max(min, Swift.min(max, self))
    }
}
