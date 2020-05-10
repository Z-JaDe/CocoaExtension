import UIKit

public extension Error {
    var string: String { String(describing: self) }
}
