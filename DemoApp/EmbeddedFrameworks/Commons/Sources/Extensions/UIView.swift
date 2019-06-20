import UIKit

extension UIView {
	// MARK: - Constructors

	/**
	 Creates and returns a new UIView with its background color set.

	 - parameter color: The view's new background color.
	 - returns: The new view.
	 */
	public static func viewWithColor(_ color: UIColor) -> UIView {
		let view = UIView()
		view.backgroundColor = color
		return view
	}

	// MARK: - Layer manipulation

	/// The view layer's corner radius.
	@IBInspectable public var cornerRadius: CGFloat {
		get { return layer.cornerRadius }
		set { layer.cornerRadius = newValue }
	}

	/// The view layer's boder width.
	@IBInspectable public var borderWidth: CGFloat {
		get { return layer.borderWidth }
		set { layer.borderWidth = newValue }
	}

	/// The view layer's border color.
	@IBInspectable public var borderColor: UIColor {
		get { return UIColor(cgColor: layer.borderColor!) }
		set { layer.borderColor = newValue.cgColor }
	}

	/// The view layer's mask to bounds flag.
	@IBInspectable public var masksToBounds: Bool {
		get { return layer.masksToBounds }
		set { layer.masksToBounds = newValue }
	}
}
