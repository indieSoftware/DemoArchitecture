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
	@IBInspectable
	public var cornerRadius: CGFloat {
		get { return layer.cornerRadius }
		set { layer.cornerRadius = newValue }
	}

	/// The view layer's boder width.
	@IBInspectable
	public var borderWidth: CGFloat {
		get { return layer.borderWidth }
		set { layer.borderWidth = newValue }
	}

	/// The view layer's border color.
	@IBInspectable
	public var borderColor: UIColor {
		get { return UIColor(cgColor: layer.borderColor!) }
		set { layer.borderColor = newValue.cgColor }
	}

	/// The view layer's mask to bounds flag.
	@IBInspectable
	public var masksToBounds: Bool {
		get { return layer.masksToBounds }
		set { layer.masksToBounds = newValue }
	}

	// MARK: - Components

	/**
	 Adds a subview to the view hierarchy via `addSubview` and executes a closure on the subview giving the possibility to set it up afterwards.

	 Inspired by [SwiftBySundell](https://www.swiftbysundell.com/articles/encapsulating-configuration-code-in-swift/)

	 Example of usage:

	 ```
	 view.add(.buyButton(
	 withTarget: self,
	 action: #selector(buyButtonTapped)
	 ), then: {
	 NSLayoutConstraint.activate([
	 $0.topAnchor.constraint(equalTo: view.topAnchor),
	 $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
	 ...
	 ])
	 })
	 ```

	 - parameters:
	    - subview: The subview to add to the view hierarchy.
	    - closure: The closure executed after adding the subview. The closure's paramter is the subview.
	 - returns: The subview added.
	 */
	@discardableResult
	public func add<T: UIView>(_ subview: T, then closure: (T) -> Void) -> T {
		addSubview(subview)
		closure(subview)
		return subview
	}
}
