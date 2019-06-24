/**
 A wrapper for applying styles to views.

 Example of usage:

 ```
 extension ViewStyle where T: UIButton {
 public static var filled: ViewStyle<UIButton> {
 return ViewStyle<UIButton> {
 $0.setTitleColor(.white, for: .normal)
 $0.backgroundColor = .red
 }
 }
 ```

 - SeeAlso: [Inspiration](https://felginep.github.io/2019-02-19/uiview-styling-with-functions)
 */
public struct ViewStyle<T> {
	/// The code to execute the provided component's styling.
	public let style: (T) -> Void

	public init(_ style: @escaping (T) -> Void) {
		self.style = style
	}
}

public protocol Stylable {
	init()
}

extension UIView: Stylable {}

extension Stylable {
	/**
	 Initializes a view with a given style applied.

	 Example of usage:

	 ```
	 let button = UIButton(style: .roundedAndFilled)
	 ```

	 - parameter style: The style to apply.
	 */
	public init(style: ViewStyle<Self>) {
		self.init()
		apply(style)
	}

	/**
	 Applies a style to this view.

	 Example of usage:

	 ```
	 let button = UIButton()
	 button.apply(.filled).apply(.rounded)
	 ```

	 - parameter style: The style to apply.
	 */
	@discardableResult
	public func apply(_ style: ViewStyle<Self>) -> Self {
		style.style(self)
		return self
	}
}
