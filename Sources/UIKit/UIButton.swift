import UIKit

extension UIButton {
    public func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        self.setBackgroundImage(UIImage.create(color: color), for: state)
    }
    public func changeToTemplate(isTemplate: Bool = true, color: UIColor?, for state: UIControl.State) {
        var image = self.image(for: state)
        image = isTemplate ? image?.templateImage : image?.originalImage
        self.setImage(image, for: state)
        self.tintColor = color
    }
}
