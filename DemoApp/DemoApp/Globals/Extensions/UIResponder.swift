import UIKit

extension UIResponder {
	/**
	 Calls resign first responder from which ever control currently is the first responder.

	 - returns: `true` if a first responder could handle the action, otherwise `false`.
	 */
	@discardableResult
	public static func resignFirstResponder() -> Bool {
		return UIApplication.shared.sendAction(NSSelectorFromString("resignFirstResponder"), to: nil, from: nil, for: nil)
	}

	/**
	 Searchs for the responder object which is currently the first responder by asking the application for it.

	 - returns: The current first responder if there is any.
	 */
	public static func findFirstResponder() -> UIResponder? {
		firstResponderReference = nil
		UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
		return firstResponderReference
	}

	/// The static reference to the first responder last found by `findFirstResponder()`.
	private weak static var firstResponderReference: UIResponder?

	/// The helper method which gets called by the application via ´findFirstResponder()` when this object is currently the first responder.
	@objc
	public func findFirstResponder(_ sender: Any) {
		UIResponder.firstResponderReference = self
	}
}
