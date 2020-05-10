import UIKit

public extension Date {
    /// ZJaDe: 根据format和 字符串, 生成日期
    init?(fromString string: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        self = formatter.date(from: string) ?? Date()
    }

    /// ZJaDe: 把日期转化成字符串
    func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    /// ZJaDe: 根据format，把日期转化成字符串
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

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

    /// ZJaDe: 返回一个时间流逝的字符串
    func timePassed() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: self, to: date, options: [])
        if components.year! >= 1 {
//            return "\(components.year ?? -1) 年前"
            return self.toString(format: "YYYY-MM-dd")
        } else if components.month! >= 1 {
//            return "\(components.month ?? -1) 个月前"
            return self.toString(format: "MM-dd")
        } else if components.day! > 2 {
//            return "\(components.day ?? -1) 天前"
            return self.toString(format: "MM-dd hh: mm")
        } else if components.day! == 2 {
            return self.toString(format: "前天hh: mm")
        } else if components.day! == 1 {
            return self.toString(format: "昨天hh: mm")
        } else if components.hour! >= 1 {
//            return "\(components.hour ?? -1) 个小时前"
            return self.toString(format: "hh: mm")
        } else if components.minute! >= 1 {
            return "\(components.minute ?? -1) 分钟前"
        } else if components.second == 0 {
            return "刚刚"
        } else {
            return "\(components.second ?? -1) 秒前"
        }
    }
}
public extension Date {
    func add(seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> Date {
        var date = addSeconds(seconds: seconds)
        date = addMinutes(minutes: minutes)
        date = addHours(hours: hours)
        date = addDays(days: days)
        date = addWeeks(weeks: weeks)
        date = addMonths(months: months)
        date = addYears(years: years)

        return date
    }
    func addSeconds (seconds: Int) -> Date {
        return NSCalendar.current.date(byAdding: .second, value: seconds, to: self)!
    }
    func addMinutes (minutes: Int) -> Date {
        return NSCalendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    func addHours(hours: Int) -> Date {
        return NSCalendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    func addDays(days: Int) -> Date {
        return NSCalendar.current.date(byAdding: .day, value: days, to: self)!
    }
    func addWeeks(weeks: Int) -> Date {
        return NSCalendar.current.date(byAdding: .weekday, value: weeks, to: self)!
    }
    func addMonths(months: Int) -> Date {
        return NSCalendar.current.date(byAdding: .month, value: months, to: self)!
    }
    func addYears(years: Int) -> Date {
        return NSCalendar.current.date(byAdding: .year, value: years, to: self)!
    }

    func isAfter(date: Date) -> Bool {
        return (self.compare(date) == ComparisonResult.orderedDescending)
    }

    func isBefore(date: Date) -> Bool {
        return (self.compare(date) == ComparisonResult.orderedAscending)
    }
}
public extension Date {
    var year: Int {
        return getComponent(.year)
    }

    var month: Int {
        return getComponent(.month)
    }

    var weekday: Int {
        return getComponent(.weekday)
    }

    var weekMonth: Int {
        return getComponent(.weekOfMonth)
    }

    var days: Int {
        return getComponent(.day)
    }

    var hours: Int {
        return getComponent(.hour)
    }

    var minutes: Int {
        return getComponent(.minute)
    }

    var seconds: Int {
        return getComponent(.second)
    }

    var calendar: Calendar {
        return Calendar.current
    }

    func getComponent (_ component: Calendar.Component) -> Int {
        return calendar.component(component, from: self)
    }
}
