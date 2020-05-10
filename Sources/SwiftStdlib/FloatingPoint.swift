import Foundation
import Darwin
public extension FloatingPoint {
    /// ZJaDe: 绝对值
//    func abs () -> Self {
//        return Foundation.fabs(self)
//    }
    /// ZJaDe: 去除负数
    var toPositiveNumber: Self {
        return max(self, 0)
    }
    /// ZJaDe: 平方根
    func sqrt() -> Self {
        return Darwin.sqrt(self)
    }
    /// ZJaDe: 向下取整
    func floor() -> Self {
        return Darwin.floor(self)
    }
    /// ZJaDe: 向上取整
    func ceil() -> Self {
        return Darwin.ceil(self)
    }
    /// ZJaDe: 四舍五入
    func round() -> Self {
        return Darwin.round(self)
    }
    /// ZJaDe: 根据increment 四舍五入
    func roundToNearest(increment: Self) -> Self {
        let remainder = self.truncatingRemainder(dividingBy: increment)
        return remainder < increment / 2 ? self - remainder : self - remainder + increment
    }
    /// ZJaDe: 根据increment 向上取整
    func ceilToNearest(increment: Self) -> Self {
        let remainder = self.truncatingRemainder(dividingBy: increment)
        return remainder > 0 ? self - remainder + increment : self
    }
    /// ZJaDe: 根据increment 向下取整
    func floorToNearest(increment: Self) -> Self {
        let remainder = self.truncatingRemainder(dividingBy: increment)
        return self - remainder
    }

}
public extension BinaryFloatingPoint where Self.RawSignificand: FixedWidthInteger {
    /// ZJaDe: 返回随机数
    static func random(min: Self = 0, max: Self = 1) -> Self {
        return random(in: min...max)
    }
}
