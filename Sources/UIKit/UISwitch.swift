import UIKit

#if os(iOS)

extension UISwitch {
	public func toggle() {
		self.setOn(!self.isOn, animated: true)
	}
}

#endif
