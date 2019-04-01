import Anchorage
import Shared
import UIKit

/**
 A custom, rounded button.
 */
public class RoundedButton: UIButton {
	public init() {
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
	 */
	func configureView() {
		apply(.roundedAndFilled)
	}
}
