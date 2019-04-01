import Anchorage
import CustomViews
import Shared
import UIKit

/**
 The scene's root view.
 The root view is responsible for creating the view hierarchy and holds all subview references.
 */
final class Scene2View: BaseView {
	override func configureView() {
		super.configureView()
		accessibilityIdentifier = Const.Scene2Tests.mainView

		// Position the headline at the top.
		addSubview(headlineLabel)
		headlineLabel.topAnchor == layoutMarginsGuide.topAnchor
		headlineLabel.leadingAnchor == layoutMarginsGuide.leadingAnchor
		headlineLabel.trailingAnchor == layoutMarginsGuide.trailingAnchor

		// The switch goes under the headline.
		addSubview(rotationLockSwitch)
		rotationLockSwitch.topAnchor == headlineLabel.bottomAnchor + Const.Margin.gap
		rotationLockSwitch.leadingAnchor == layoutMarginsGuide.leadingAnchor

		// The counter field goes under the switch.
		addSubview(counterTextField)
		counterTextField.topAnchor == rotationLockSwitch.bottomAnchor + Const.Margin.gap
		counterTextField.leadingAnchor == layoutMarginsGuide.leadingAnchor
		counterTextField.trailingAnchor == layoutMarginsGuide.trailingAnchor

		// The dismiss button goes under the dismiss button.
		addSubview(dismissButton)
		dismissButton.topAnchor == counterTextField.bottomAnchor + Const.Margin.gap
		dismissButton.leadingAnchor == layoutMarginsGuide.leadingAnchor
		dismissButton.trailingAnchor <= layoutMarginsGuide.trailingAnchor

		// Set default styles.
		backgroundColor = R.color.scene2Background()
		directionalLayoutMargins = Const.Margin.default.directional
	}

	// MARK: - Subviews

	/// The headline label.
	let headlineLabel: UILabel = {
		let label = UILabel()
		return label
	}()

	/// The input field showing the current coutner value.
	let counterTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .bezel
		textField.clearButtonMode = .always
		textField.keyboardType = .numberPad
		return textField
	}()

	/// The dismiss button.
	let dismissButton: RoundedButton = {
		let button = RoundedButton()
		button.setTitle(R.string.scene2.dismissButtonTitle(), for: .normal)
		return button
	}()

	/// The rotation lock switch.
	let rotationLockSwitch: UISwitch = {
		let view = UISwitch()
		return view
	}()

	// MARK: - View changes

	/**
	 Adds the embedded view of a sub-controller to the view hierarchy.

	 - parameter subView: The sub-controller's view.
	 */
	func addEmbeddedView(_ subView: UIView) {
		addSubview(subView)
		subView.topAnchor == dismissButton.bottomAnchor + Const.Margin.gap
		subView.leadingAnchor == layoutMarginsGuide.leadingAnchor
		subView.trailingAnchor == layoutMarginsGuide.trailingAnchor
		subView.bottomAnchor == layoutMarginsGuide.bottomAnchor
	}

	// MARK: - Interface Builder

	@IBInspectable private lazy var ibBackgroundColor: UIColor = .white
	@IBInspectable private lazy var ibHeadlineTitle: String = "Headline title"

	override func prepareForInterfaceBuilder() {
		// For crash reports look at '~/Library/Logs/DiagnosticReports/'.
		super.prepareForInterfaceBuilder()
		backgroundColor = ibBackgroundColor

		headlineLabel.text = ibHeadlineTitle
	}
}
