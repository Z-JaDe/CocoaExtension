//
//  CalendarMath.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/12/6.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

extension Int {
    private func mathForUnit(unit: Calendar.Component) -> CalendarMath {
        return CalendarMath(unit: unit, value: self)
    }
    var seconds: CalendarMath {
        return mathForUnit(unit: .second)
    }
    var second: CalendarMath {
        return seconds
    }

    var minutes: CalendarMath {
        return mathForUnit(unit: .minute)
    }
    var minute: CalendarMath {
        return minutes
    }

    var hours: CalendarMath {
        return mathForUnit(unit: .hour)
    }
    var hour: CalendarMath {
        return hours
    }

    var days: CalendarMath {
        return mathForUnit(unit: .day)
    }
    var day: CalendarMath {
        return days
    }

    var weeks: CalendarMath {
        return mathForUnit(unit: .weekOfYear)
    }
    var week: CalendarMath {
        return weeks
    }

    var months: CalendarMath {
        return mathForUnit(unit: .month)
    }
    var month: CalendarMath {
        return months
    }

    var years: CalendarMath {
        return mathForUnit(unit: .year)
    }
    var year: CalendarMath {
        return years
    }
}
public struct CalendarMath {
    private let unit: Calendar.Component
    private let value: Int
    private var calendar: Calendar {
        return NSCalendar.autoupdatingCurrent
    }

    public init(unit: Calendar.Component, value: Int) {
        self.unit = unit
        self.value = value
    }

    private func generateComponents(modifer: (Int) -> (Int) = (+)) -> DateComponents {
        var components = DateComponents()
        components.setValue(modifer(value), for: unit)
        return components
    }

    public func from(date: Date) -> Date? {
        return calendar.date(byAdding: generateComponents(), to: date)
    }

    public var fromNow: Date? {
        return from(date: Date())
    }

    public func before(date: Date) -> Date? {
        return calendar.date(byAdding: generateComponents(modifer: -), to: date)
    }

    public var ago: Date? {
        return before(date: Date())
    }
}
