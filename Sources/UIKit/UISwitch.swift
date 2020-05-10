import UIKit

#if os(iOS)

public extension UISwitch {
    func toggle() {
		self.setOn(!self.isOn, animated: true)
	}
}

#endif
