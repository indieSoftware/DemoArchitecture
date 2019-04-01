import UIKit

/**
 A base view to derive from instead directly from UIView.
 Override `configureView` to set up the view hierarchy and layout.
 */
@IBDesignable
class BaseView: UIView {
	init() {
		super.init(frame: .zero)
		configureView()
	}

	@available(*, deprecated, message: "Use `init()` instead.")
	override init(frame: CGRect) {
		// Needed to render in InterfaceBuilder.
		super.init(frame: frame)
		configureView()
	}

	@available(*, unavailable, message: "Instantiating via Xib & Storyboard is prohibited.")
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 Builds up the view hierarchy and applies the layout.
	 Subclasses should override this method to set up the view's content and layout.
	 The base implementation does nothing.
	 */
	func configureView() {
		// Needs to be implemented by subclasses.
	}
}
