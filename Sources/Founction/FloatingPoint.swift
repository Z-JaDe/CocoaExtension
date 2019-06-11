import Foundation

extension FloatingPoint {
    /// ZJaDe: 绝对值
//    public func abs () -> Self {
//        return Foundation.fabs(self)
//    }
    /// ZJaDe: 去除负数
    public var toPositiveNumber: Self {
        return max(self, 0)
    }
    /// ZJaDe: 平方根
    public func sqrt() -> Self {
        return Foundation.sqrt(self)
    }
    /// ZJaDe: 向下取整
    public func floor() -> Self {
        return Foundation.floor(self)
    }
    /// ZJaDe: 向上取整
    public func ceil() -> Self {
        return Foundation.ceil(self)
    }
    /// ZJaDe: 四舍五入
    public func round() -> Self {
        return Foundation.round(self)
    }
    /// ZJaDe: 根据increment 四舍五入
    public func roundToNearest(increment: Self) -> Self {
        let remainder = self.truncatingRemainder(dividingBy: increment)
        return remainder < increment / 2 ? self - remainder : self - remainder + increment
    }
    /// ZJaDe: 根据increment 向上取整
    public func ceilToNearest(increment: Self) -> Self {
        let remainder = self.truncatingRemainder(dividingBy: increment)
        return remainder > 0 ? self - remainder + increment : self
    }
    /// ZJaDe: 根据increment 向下取整
    public func floorToNearest(increment: Self) -> Self {
        let remainder = self.truncatingRemainder(dividingBy: increment)
        return self - remainder
    }

}
extension BinaryFloatingPoint where Self.RawSignificand: FixedWidthInteger {
    /// ZJaDe: 返回随机数
    public static func random(min: Self = 0, max: Self = 1) -> Self {
        return random(in: min...max)
    }
}
