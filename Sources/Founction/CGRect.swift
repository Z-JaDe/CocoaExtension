import UIKit

extension CGRect {
    public var leftTop: CGPoint {
        return self.origin
    }
    public var leftBottom: CGPoint {
        return CGPoint(x: self.minX, y: self.maxY)
    }
    public var rightTop: CGPoint {
        return CGPoint(x: self.maxX, y: self.minY)
    }
    public var rightBottom: CGPoint {
        return CGPoint(x: self.maxX, y: self.maxY)
    }
}
extension CGRect {
    public static func - (left: CGRect, right: UIEdgeInsets) -> CGRect {
        return left.inset(by: right)
    }
    public static func + (left: CGRect, right: UIEdgeInsets) -> CGRect {
        var left = left
        left.size.width += right.left + right.right
        left.size.height += right.top + right.bottom
        left.origin.x -= right.left
        left.origin.y -= right.top
        return left
    }
}
extension CGSize {
    public static func + (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width + right.width, height: left.height + right.height)
    }
    public static func += (left: inout CGSize, right: CGSize) {
        left = CGSize(width: left.width + right.width, height: left.height + right.height)
    }

}
extension CGPoint {
    public func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + dx, y: self.y + dy)
    }
}
