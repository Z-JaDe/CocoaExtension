import UIKit

public extension CGRect {
    var leftTop: CGPoint {
        self.origin
    }
    var leftBottom: CGPoint {
        CGPoint(x: self.minX, y: self.maxY)
    }
    var rightTop: CGPoint {
        CGPoint(x: self.maxX, y: self.minY)
    }
    var rightBottom: CGPoint {
        CGPoint(x: self.maxX, y: self.maxY)
    }
}
public extension CGRect {
    static func - (left: CGRect, right: UIEdgeInsets) -> CGRect {
        left.inset(by: right)
    }
    static func + (left: CGRect, right: UIEdgeInsets) -> CGRect {
        var left = left
        left.size += right
        left.origin.x -= right.left
        left.origin.y -= right.top
        return left
    }
}
public extension CGRect {
    /// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
    func flat() -> Self {
        return CGRect(x: origin.x.flat(), y: origin.y.flat(), width: size.width.flat(), height: size.height.flat())
    }
}
