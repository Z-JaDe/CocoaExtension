import Foundation

extension Double {
    /// ZJaDe: 返回一个四舍五入保留places位的小数
    public func getRoundedByPlaces(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places)) as Double
        var result = Double(self * divisor) / divisor
        result.round(.toNearestOrAwayFromZero)
        return result
    }

    /// ZJaDe: 转换成一个四舍五入保留places位的小数
    public mutating func roundByPlaces(_ places: Int) {
        self = getRoundedByPlaces(places)
    }

    /// ZJaDe: 返回一个直接截取保留places位的小数
    public func getCeiledByPlaces(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Foundation.ceil(self * divisor) / divisor
    }
}
