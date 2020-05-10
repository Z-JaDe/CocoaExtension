//
//  Date+string.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public extension Date {
    /// ZJaDe: 根据format和 字符串, 生成日期
    init?(fromString string: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        self = formatter.date(from: string) ?? Date()
    }

    /// ZJaDe: 把日期转化成字符串
    func string(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    /// ZJaDe: 根据format，把日期转化成字符串
    func string(format: String ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    /// ZJaDe: 返回一个时间流逝的字符串
    func timePassed() -> String {
        let date = Date()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: date)
        if components.year! >= 1 {
//            return "\(components.year ?? -1) 年前"
            return string(format: "YYYY-MM-dd")
        } else if components.month! >= 1 {
//            return "\(components.month ?? -1) 个月前"
            return string(format: "MM-dd")
        } else if components.day! > 2 {
//            return "\(components.day ?? -1) 天前"
            return string(format: "MM-dd hh: mm")
        } else if components.day! == 2 {
            return string(format: "前天hh: mm")
        } else if components.day! == 1 {
            return string(format: "昨天hh: mm")
        } else if components.hour! >= 1 {
//            return "\(components.hour ?? -1) 个小时前"
            return string(format: "hh: mm")
        } else if components.minute! >= 1 {
            return "\(components.minute ?? -1) 分钟前"
        } else if components.second == 0 {
            return "刚刚"
        } else {
            return "\(components.second ?? -1) 秒前"
        }
    }

    var iso8601String: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        return dateFormatter.string(from: self).appending("Z")
    }
}
