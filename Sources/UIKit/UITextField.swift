import UIKit

public extension UITextField {
    convenience init(text: String? = nil, placeholder: String? = nil, color: UIColor, font: UIFont) {
        self.init()
        self.text = text
        self.placeholder = placeholder
        self.textColor = color
        self.font = font
    }

}
