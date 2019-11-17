import UIKit

extension UIButton {
    public func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        self.setBackgroundImage(UIImage.create(color: color), for: state)
    }
    public func setTitle(_ title: String?, _ color: UIColor?, _ font: UIFont?, for state: UIControl.State) {
        self.setTitle(title, for: state)
        self.setTitleColor(color, for: state)
        if let title = title {
            var attributes: [NSAttributedString.Key: Any] = [:]
            attributes[.foregroundColor] = color
            attributes[.font] = font
            self.setAttributedTitle(NSAttributedString(string: title, attributes: attributes), for: state)
        } else {
            self.setAttributedTitle(nil, for: state)
        }
    }
    public func changeToTemplate(isTemplate: Bool = true, color: UIColor?, for state: UIControl.State) {
        var image = self.image(for: state)
        image = isTemplate ? image?.templateImage : image?.originalImage
        self.setImage(image, for: state)
        self.tintColor = color
    }
}
