//
//  CalendarMath.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/6.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

extension Int {
    private func mathForUnit(unit: Calendar.Component) -> CalendarMath {
        return CalendarMath(unit: unit, value: self)
    }
    public var seconds: CalendarMath {
        return mathForUnit(unit: .second)
    }
    public var second: CalendarMath {
        return seconds
    }

    public var minutes: CalendarMath {
        return mathForUnit(unit: .minute)
    }
    public var minute: CalendarMath {
        return minutes
    }

    public var hours: CalendarMath {
        return mathForUnit(unit: .hour)
    }
    public var hour: CalendarMath {
        return hours
    }

    public var days: CalendarMath {
        return mathForUnit(unit: .day)
    }
    public var day: CalendarMath {
        return days
    }

    public var weeks: CalendarMath {
        return mathForUnit(unit: .weekOfYear)
    }
    public var week: CalendarMath {
        return weeks
    }

    public var months: CalendarMath {
        return mathForUnit(unit: .month)
    }
    public var month: CalendarMath {
        return months
    }

    public var years: CalendarMath {
        return mathForUnit(unit: .year)
    }
    public var year: CalendarMath {
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
