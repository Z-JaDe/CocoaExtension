import UIKit

public extension UITextField {
    convenience init(text: String? = nil, placeholder: String? = nil, color: UIColor, font: UIFont) {
        self.init()
        self.text = text
        self.placeholder = placeholder
        self.textColor = color
        self.font = font
    }
    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        leftView = imageView
        leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        leftViewMode = .always
    }
}
