import UIKit

public extension UIViewController {
    // MARK: - VC Flow
    func popVC(popCount: Int = 1, animated: Bool = true) {
        if popCount <= 1 {
            _ = navigationController?.popViewController(animated: animated)
        } else {
            navigationController?.pop(count: popCount, animated: animated)
        }
    }

    #if os(iOS)
    func presentPopover(_ popoverContent: UIViewController, sourcePoint: CGPoint, size: CGSize? = nil, delegate: UIPopoverPresentationControllerDelegate? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        popoverContent.modalPresentationStyle = .popover

        if let size = size {
            popoverContent.preferredContentSize = size
        }

        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }

        present(popoverContent, animated: animated, completion: completion)
    }
    #endif
}
public extension UIViewController {
    func addAsChildViewController(_ childVC: UIViewController, toView: UIView? = nil) {
        self.addChild(childVC)
        let toView: UIView = toView ?? self.view
        toView.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    func removeAsFromParentViewController() {
        // ZJaDe: 当我们向我们的视图控制器容器中调用removeFromParentViewController方法时，必须要先调用该方法，且parent参数为nil：
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
public extension UIViewController {
    func parentVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        if let viewCon = self.parent as? T {
            return viewCon
        }
        return nil
    }
    func findParentVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        if let viewCon = self.parentVC(T.self) {
            return viewCon
        } else {
            return self.parentVC(UIViewController.self)?.findParentVC(T.self)
        }
    }
    func childVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        self.children.first(where: {$0 is T}) as? T
    }
    func previousVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        guard let navC = self.navigationController else { return nil }
        if let index = navC.viewControllers.firstIndex(of: self), index >= 1 {
            if let viewCon = navC.viewControllers[index-1] as? T {
                return viewCon
            }
        }
        return nil
    }
    func findPreviousVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        if let viewCon = self.previousVC(T.self) {
            return viewCon
        } else {
            return self.previousVC(UIViewController.self)?.previousVC(T.self)
        }
    }
}
