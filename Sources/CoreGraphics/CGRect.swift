import UIKit

public extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    var leftTop: CGPoint {
        origin
    }
    var leftBottom: CGPoint {
        CGPoint(x: minX, y: maxY)
    }
    var rightTop: CGPoint {
        CGPoint(x: maxX, y: minY)
    }
    var rightBottom: CGPoint {
        CGPoint(x: maxX, y: maxY)
    }
    func resizing(to size: CGSize, anchor: CGPoint = CGPoint(x: 0.5, y: 0.5)) -> CGRect {
        let sizeDelta = CGSize(width: size.width - width, height: size.height - height)
        return CGRect(origin: CGPoint(x: minX - sizeDelta.width * anchor.x,
                                      y: minY - sizeDelta.height * anchor.y),
                      size: size)
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
        CGRect(x: origin.x.flat(), y: origin.y.flat(), width: size.width.flat(), height: size.height.flat())
    }
}
