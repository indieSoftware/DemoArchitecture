import UIKit

extension UIDevice {
	/// True if the current device is an iPad, otherwise false.
	public static var isIPad: Bool {
		return current.userInterfaceIdiom == .pad
	}

	/**
	 Sets the orientation manually with force.

	 - parameter orientation: The orientation to set.
	 */
	public static func setOrientation(_ orientation: UIInterfaceOrientation) {
		current.setValue(orientation.rawValue, forKey: "orientation")
	}
}
