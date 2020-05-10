import Foundation
import UIKit

public extension UIUserInterfaceSizeClass {
    var stringValue: String {
        switch self.rawValue {
        case 1:
            return "Compact"
        case 2:
            return "Regular"
        default:
            return "Unspecified"
        }
    }
}
