import UIKit

public extension UIImageView {
    /// ZJaDe:  scales this ImageView size to fit the given width
    func scaleImageFrameToWidth(width: CGFloat) {
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
    func scaleImageFrameToHeight(height: CGFloat) {
        guard let image = image else {
            print("ZJaDe Error：没设置图片")
            return
        }
        let heightRatio = image.size.height / height
        let newHeight = image.size.height / heightRatio
        let newWidth = image.size.width / heightRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeight)
    }

    func setAsyncImage(_ getImage: @escaping @autoclosure () -> UIImage?) {
        DispatchQueue.global().async {
            let image = getImage()
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        clipsToBounds = true
    }
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = self
        imgView.blur(withStyle: style)
        return imgView
    }
}
