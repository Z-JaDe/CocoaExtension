import UIKit

extension UIButton {
    public func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        self.setBackgroundImage(UIImage.createResizable().color(color).image, for: state)
    }
    public func changeToTemplate(isTemplate: Bool = true, color: UIColor?) {
        var image = self.imageView?.image
        image = isTemplate ? image?.templateImage : image?.originalImage
        self.setImage(image, for: .normal)
        self.tintColor = color
    }
}
