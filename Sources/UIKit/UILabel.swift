import UIKit

extension UILabel {
    public convenience init(text: String? = nil, color: UIColor, font: UIFont) {
        self.init()
        self.text = text
        self.textColor = color
        self.font = font
    }
    // MARK: -
    public func setText(_ text: String?, animated: Bool, duration: TimeInterval?) {
        if animated {
            UIView.transition(with: self, duration: duration ?? 0.3, options: .transitionCrossDissolve, animations: { () -> Void in
                self.text = text
                }, completion: nil)
        } else {
            self.text = text
        }

    }
}
