import Foundation

public extension Bundle {

    /// ZJaDe: 加载nib
    static func loadNib<T>(_ name: String, owner: AnyObject? = nil) -> T? {
        return Bundle.main.loadNibNamed(name, owner: owner, options: nil)?[0] as? T
    }

}
