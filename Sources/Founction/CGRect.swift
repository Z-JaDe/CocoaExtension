import UIKit

extension CGRect {
    public var leftTop: CGPoint {
        self.origin
    }
    public var leftBottom: CGPoint {
        CGPoint(x: self.minX, y: self.maxY)
    }
    public var rightTop: CGPoint {
        CGPoint(x: self.maxX, y: self.minY)
    }
    public var rightBottom: CGPoint {
        CGPoint(x: self.maxX, y: self.maxY)
    }
}
extension CGRect {
    public static func - (left: CGRect, right: UIEdgeInsets) -> CGRect {
        left.inset(by: right)
    }
    public static func + (left: CGRect, right: UIEdgeInsets) -> CGRect {
        var left = left
        left.size += right
        left.origin.x -= right.left
        left.origin.y -= right.top
        return left
    }
}
extension CGRect {
    /// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
    public func flat() -> Self {
        return CGRect(x: origin.x.flat(), y: origin.y.flat(), width: size.width.flat(), height: size.height.flat())
    }
}
extension CGSize {
    public static func + (left: CGSize, right: UIEdgeInsets) -> CGSize {
        var left = left
        left.width += right.horizontal
        left.height += right.vertical
        return left
    }
    public static func += (left: inout CGSize, right: UIEdgeInsets) {
        // swiftlint:disable shorthand_operator
        left = left + right
    }
    public static func - (left: CGSize, right: UIEdgeInsets) -> CGSize {
        var left = left
        left.width -= right.horizontal
        left.height -= right.vertical
        return left
    }
    public static func -= (left: inout CGSize, right: UIEdgeInsets) {
        // swiftlint:disable shorthand_operator
        left = left - right
    }
    public static func + (left: CGSize, right: CGSize) -> CGSize {
        CGSize(width: left.width + right.width, height: left.height + right.height)
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
extension UIEdgeInsets {
    public var horizontal: CGFloat {
        left + right
    }
    public var vertical: CGFloat {
        top + bottom
    }
}
