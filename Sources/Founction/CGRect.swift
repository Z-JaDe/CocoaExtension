import UIKit

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
