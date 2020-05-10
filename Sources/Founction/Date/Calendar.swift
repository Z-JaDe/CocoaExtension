//
//  Calendar.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

// MARK: - Methods
public extension Calendar {
    func numberOfDaysInMonth(for date: Date) -> Int {
        return range(of: .day, in: .month, for: date)!.count
    }
}
public extension Date {
    var calendar: Calendar {
        Calendar.current
    }
    func getComponent(_ component: Calendar.Component) -> Int {
        calendar.component(component, from: self)
    }
    mutating func changing(_ component: Calendar.Component, _ value: Int) {
        let current = calendar.component(component, from: self)
        add(component, value: value - current)
    }
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return calendar.date(byAdding: component, value: value, to: self)!
    }
    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }
}
