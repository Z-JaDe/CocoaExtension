import UIKit

extension UIViewController {
    // MARK: - VC Flow
//    public func pushVC(_ vc: UIViewController) {
//        navigationController?.pushViewController(vc, animated: true)
//    }
    public func popVC(popCount: Int = 1, animated: Bool = true) {
        if popCount <= 1 {
            _ = navigationController?.popViewController(animated: animated)
        } else {
            navigationController?.pop(count: popCount, animated: animated)
        }
    }

    public func dismissVC(animated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }

//    @discardableResult
//    public func popToVC<T: UIViewController>(_ vcType: T.Type) -> T? {
//        if let viewCon = navigationController?.viewControllers.filter({$0 is T}).last {
//            _ = navigationController?.popToViewController(viewCon, animated: true)
//            return viewCon as? T
//        } else {
//            return nil
//        }
//    }
}
extension UIViewController {
    open func addAsChildViewController(_ vc: UIViewController, toView: UIView? = nil) {
        let toView: UIView = toView ?? self.view
        toView.addSubview(vc.view)
        self.addChildVC(vc)
    }
    public func removeAsChildViewController(_ vc: UIViewController, needRemoveItem: UIView? = nil) {
        let needRemoveItem: UIView = needRemoveItem ?? vc.view
        needRemoveItem.removeFromSuperview()
        vc.removeFromParentVC()
    }
    open func removeAsFromParentViewController() {
        self.view.removeFromSuperview()
        self.removeFromParentVC()
    }

    open func addChildVC(_ childVC: UIViewController) {
        self.addChild(childVC)
        childVC.didMove(toParent: self)
    }
    open func removeFromParentVC() {
        // ZJaDe: 当我们向我们的视图控制器容器中调用removeFromParentViewController方法时，必须要先调用该方法，且parent参数为nil：
        self.willMove(toParent: nil)
        self.removeFromParent()
    }
}
extension UIViewController {
    public func parentVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        if let viewCon = self.parent as? T {
            return viewCon
        } else {
            return nil
        }
    }
    public func findParentVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        if let viewCon = self.parentVC(T.self) {
            return viewCon
        } else {
            return self.parentVC(UIViewController.self)?.findParentVC(T.self)
        }
    }
    public func childVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        return self.children.first(where: {$0 is T}) as? T
    }
    public func previousVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        guard let navC = self.navigationController else { return nil }
        if let index = navC.viewControllers.firstIndex(of: self), index >= 1 {
            if let viewCon = navC.viewControllers[index-1] as? T {
                return viewCon
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    public func findPreviousVC<T: UIViewController>(_ vcType: T.Type) -> T? {
        if let viewCon = self.previousVC(T.self) {
            return viewCon
        } else {
            return self.previousVC(UIViewController.self)?.previousVC(T.self)
        }
    }
}
