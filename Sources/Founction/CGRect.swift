import UIKit

extension CGRect {
    public var x: CGFloat {
        get {
            return self.origin.x
        } set(value) {
            self.origin.x = value
        }
    }
    public var y: CGFloat {
        get {
            return self.origin.y
        } set(value) {
            self.origin.y = value
        }
    }
    public var width: CGFloat {
        get {
            return self.size.width
        } set(value) {
            self.size.width = value
        }
    }
    public var height: CGFloat {
        get {
            return self.size.height
        } set(value) {
            self.size.height = value
        }
    }
}
extension CGRect {
    public static func - (left: CGRect, right: UIEdgeInsets) -> CGRect {
        var left = left
        left.width -= right.left + right.right
        left.height -= right.top + right.bottom
        left.x += right.left
        left.y += right.top
        return left
    }
    public static func + (left: CGRect, right: UIEdgeInsets) -> CGRect {
        var left = left
        left.width += right.left + right.right
        left.height += right.top + right.bottom
        left.x -= right.left
        left.y -= right.top
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
