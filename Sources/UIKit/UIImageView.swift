import UIKit

extension UIImageView {
    /// ZJaDe:  scales this ImageView size to fit the given width
    public func scaleImageFrameToWidth(width: CGFloat) {
        guard let image = image else {
            print("ZJaDe Error：没设置图片")
            return
        }
        let widthRatio = image.size.width / width
        let newWidth = image.size.width / widthRatio
        let newHeigth = image.size.height / widthRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeigth)
    }

    /// ZJaDe:  scales this ImageView size to fit the given height
    public func scaleImageFrameToHeight(height: CGFloat) {
        guard let image = image else {
            print("ZJaDe Error：没设置图片")
            return
        }
        let heightRatio = image.size.height / height
        let newHeight = image.size.height / heightRatio
        let newWidth = image.size.width / heightRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeight)
    }

}
