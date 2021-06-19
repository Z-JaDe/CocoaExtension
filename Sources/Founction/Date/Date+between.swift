//
//  Date+between.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public extension Date {
    /// ZJaDe: 两个日期之间的总天数
    func daysInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/86400)
        return diff
    }

    /// ZJaDe: 两个日期之间的总小时数
    func hoursInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/3600)
        return diff
    }

    /// ZJaDe: 两个日期之间的总分钟数
    func minutesInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/60)
        return diff
    }

    /// ZJaDe: 两个日期之间的总秒数
    func secondsInBetweenDate(_ date: Date) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }
}
