import UIKit

extension UIEdgeInsets {
	/**
	 Converts the `UIEdgeInsets` struct into a `NSDirectionalEdgeInsets` where the `left` value is treated as the `leading` and
	 the `right` as the `trailing`.
	 */
	@available(iOS 11.0, *)
	public var directional: NSDirectionalEdgeInsets {
		return NSDirectionalEdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
	}

	/**
	 Returns a new edge insets with the value for `top` replaced.

	 - parameter newValue: The new value for `top`.
	 - returns: The edge insets with the value replaced.
	 */
	public func top(_ newValue: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: newValue, left: left, bottom: bottom, right: right)
	}

	/**
	 Returns a new edge insets with the value for `left` replaced.

	 - parameter newValue: The new value for `left`.
	 - returns: The edge insets with the value replaced.
	 */
	public func left(_ newValue: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: top, left: newValue, bottom: bottom, right: right)
	}

	/**
	 Returns a new edge insets with the value for `bottom` replaced.

	 - parameter newValue: The new value for `bottom`.
	 - returns: The edge insets with the value replaced.
	 */
	public func bottom(_ newValue: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: top, left: left, bottom: newValue, right: right)
	}

	/**
	 Returns a new edge insets with the value for `right` replaced.

	 - parameter newValue: The new value for `right`.
	 - returns: The edge insets with the value replaced.
	 */
	public func right(_ newValue: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: top, left: left, bottom: bottom, right: newValue)
	}

	/**
	 Inverts the edge insets.
	 */
	public var inverted: UIEdgeInsets {
		return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
	}
}
