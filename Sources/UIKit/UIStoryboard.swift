import UIKit

public extension UIStoryboard {

	/// ZJaDe: mainStoryboard
    static var mainStoryboard: UIStoryboard? {
		let bundle = Bundle.main
		guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {
			return nil
		}
		return UIStoryboard(name: name, bundle: bundle)
	}

	/// ZJaDe: Get view controller from storyboard by its class type
	/// Usage: let profileVC = storyboard!.instantiateVC(ProfileViewController) /* profileVC is of type ProfileViewController */
	/// Warning: identifier should match storyboard ID in storyboard of identifier class
    func instantiateVC<T>(identifier: T.Type) -> T? {
		let storyboardID = String(describing: identifier)
		if let vc = instantiateViewController(withIdentifier: storyboardID) as? T {
			return vc
		} else {
			return nil
		}
	}
}
