import UIKit

public extension UIWindow {
    /// ZJaDe: Creates and shows UIWindow. The size will show iPhone4 size until you add launch images with proper sizes.
    convenience init(viewController: UIViewController, backgroundColor: UIColor) {
        self.init(frame: UIScreen.main.bounds)
        self.rootViewController = viewController
        self.backgroundColor = backgroundColor
        self.makeKeyAndVisible()
    }

    func switchRootViewController(
        to viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.25,
        options: UIView.AnimationOptions = .transitionCrossDissolve,
        _ completion: (() -> Void)? = nil) {

        guard animated else {
            rootViewController = viewController
            completion?()
            return
        }

        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
}
