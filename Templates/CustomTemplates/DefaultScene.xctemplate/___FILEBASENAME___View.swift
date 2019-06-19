import UIKit
import Shared

/**
 The scene's root view.
 The root view is responsible for creating the view hierarchy and holds all subview references.
 */
final class ___VARIABLE_sceneName___View: BaseView {
	override func configureView() {
		super.configureView()
		accessibilityIdentifier = Const.___VARIABLE_sceneName___Tests.mainView
	}

	// MARK: - Subviews

	// MARK: - Interface Builder

	@IBInspectable private lazy var ibBackgroundColor: UIColor = .white

	override func prepareForInterfaceBuilder() {
		// For crash reports look at '~/Library/Logs/DiagnosticReports/'.
		super.prepareForInterfaceBuilder()
		backgroundColor = ibBackgroundColor
	}
}
