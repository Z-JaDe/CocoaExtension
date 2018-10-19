import UIKit

extension UIWindow {
    /// ZJaDe: Creates and shows UIWindow. The size will show iPhone4 size until you add launch images with proper sizes.
    public convenience init(viewController: UIViewController, backgroundColor: UIColor) {
        self.init(frame: UIScreen.main.bounds)
        self.rootViewController = viewController
        self.backgroundColor = backgroundColor
        self.makeKeyAndVisible()
    }
}
