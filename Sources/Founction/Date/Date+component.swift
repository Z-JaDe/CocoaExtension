//
//  Date+component.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public extension Date {
    var era: Int {
        getComponent(.era)
    }
    var weekday: Int {
        getComponent(.weekday)
    }
    var weekOfMonth: Int {
        getComponent(.weekOfMonth)
    }
    var weekOfYear: Int {
        getComponent(.weekOfYear)
    }

    var year: Int {
        get { getComponent(.year) }
        set { changing(.year, newValue) }
    }

    var month: Int {
        get { getComponent(.month) }
        set { changing(.month, newValue) }
    }

    var days: Int {
        get { getComponent(.day) }
        set { changing(.day, newValue) }
    }

    var hours: Int {
        get { getComponent(.hour) }
        set { changing(.hour, newValue) }
    }

    var minutes: Int {
        get { getComponent(.minute) }
        set { changing(.minute, newValue) }
    }

    var seconds: Int {
        get { getComponent(.second) }
        set { changing(.second, newValue) }
    }
}
public extension Date {
    var isInFuture: Bool {
        self > Date()
    }
    var isInPast: Bool {
        self < Date()
    }
    var isInToday: Bool {
        calendar.isDateInToday(self)
    }
    var isInYesterday: Bool {
        calendar.isDateInYesterday(self)
    }
    var isInTomorrow: Bool {
        calendar.isDateInTomorrow(self)
    }
    var isInWeekend: Bool {
        calendar.isDateInWeekend(self)
    }
    var isWorkday: Bool {
        !calendar.isDateInWeekend(self)
    }

    var isInCurrentWeek: Bool {
        isInCurrent(.weekOfYear)
    }
    var isInCurrentMonth: Bool {
        isInCurrent(.month)
    }
    var isInCurrentYear: Bool {
        isInCurrent(.year)
    }
    func isInCurrent(_ component: Calendar.Component) -> Bool {
        calendar.isDate(self, equalTo: Date(), toGranularity: component)
    }
}
