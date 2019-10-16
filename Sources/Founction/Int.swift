import UIKit

extension Int {
    public init?(any: Any?) {
        switch any {
        case let value as String:
            if let intValue = Int(value) {
                self = intValue
            }
        case let value as Int:
            self = value
        default: break
        }
        return nil
    }
    /// ZJaDe: Checks if the integer is even.
    public var isEven: Bool { (self % 2 == 0) }

    /// ZJaDe: Checks if the integer is odd.
    public var isOdd: Bool { (self % 2 != 0) }

    /// ZJaDe: Checks if the integer is positive.
    public var isPositive: Bool { (self > 0) }

    /// ZJaDe: Checks if the integer is negative.
    public var isNegative: Bool { (self < 0) }

    /// ZJaDe: Converts integer value to a 0..<Int range. Useful in for loops.
    public var range: CountableRange<Int> { 0..<self }

    public var toChinese: String {
        let number = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter.string(from: number) ?? "?"
    }

    /// ZJaDe: Returns number of digits in the integer.
    public var digits: Int {
        if self == 0 {
            return 1
        } else if Int(fabs(Double(self))) <= LONG_MAX {
            return Int(log10(fabs(Double(self)))) + 1
//        } else {
//            return -1; //out of bound
        }
    }
}
extension FixedWidthInteger {
    /// ZJaDe: 返回随机数
    public static func random(min: Self = 0, max: Self = 50) -> Self {
        random(in: min...max)
    }
}
