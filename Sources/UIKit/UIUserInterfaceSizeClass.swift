import Foundation
import UIKit

extension UIUserInterfaceSizeClass {
  public var stringValue: String {
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
