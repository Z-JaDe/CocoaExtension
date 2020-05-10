import UIKit

public extension Int {
    init?(any: Any?) {
        switch any {
        case let value as String:
            if let intValue = Int(value) {
                self = intValue
            }
        case let value as NSNumber:
            self = value.intValue
        case let value as Int:
            self = value
        case let value as Double:
            self = Int(value)
        case let value as Float:
            self = Int(value)
        default: break
        }
        return nil
    }
    /// ZJaDe: Checks if the integer is even.
    var isEven: Bool { (self % 2 == 0) }

    /// ZJaDe: Checks if the integer is odd.
    var isOdd: Bool { (self % 2 != 0) }

    /// ZJaDe: Checks if the integer is positive.
    var isPositive: Bool { (self > 0) }

    /// ZJaDe: Checks if the integer is negative.
    var isNegative: Bool { (self < 0) }

    /// ZJaDe: Converts integer value to a 0..<Int range. Useful in for loops.
    var range: CountableRange<Int> { 0..<self }

    var toChinese: String {
        let number = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter.string(from: number) ?? "?"
    }

    /// ZJaDe: Returns number of digits in the integer.
    var digits: Int {
        if self == 0 {
            return 1
        } else if Int(fabs(Double(self))) <= LONG_MAX {
            return Int(log10(fabs(Double(self)))) + 1
//        } else {
//            return -1; //out of bound
        }
    }
}
public extension FixedWidthInteger {
    /// ZJaDe: 返回随机数
    static func random(min: Self = 0, max: Self = 50) -> Self {
        random(in: min...max)
    }
}
