import Anchorage
import Shared
import UIKit

/**
 The scene's root view.
 The root view is responsible for creating the view hierarchy and holds all subview references.
 */
final class Scene1View: BaseView {
	override func configureView() {
		super.configureView()
		accessibilityIdentifier = Const.Scene1Tests.mainView

		// Position the headline at the top.
		addSubview(headlineLabel)
		headlineLabel.topAnchor == layoutMarginsGuide.topAnchor
		headlineLabel.leadingAnchor == layoutMarginsGuide.leadingAnchor
		headlineLabel.trailingAnchor == layoutMarginsGuide.trailingAnchor
		headlineLabel.verticalHuggingPriority = .low + 1
		headlineLabel.verticalCompressionResistance = .high + 1

		// The table view under the headline.
		addSubview(tableView)
		tableView.topAnchor == headlineLabel.bottomAnchor + Const.Margin.gap
		tableView.leadingAnchor == leadingAnchor
		tableView.trailingAnchor == trailingAnchor
		tableView.bottomAnchor == bottomAnchor

		// Set default styles.
		backgroundColor = R.color.scene1Background()
		directionalLayoutMargins = Const.Margin.default.directional
	}

	// MARK: - Subviews

	/// The headline label.
	let headlineLabel: UILabel = {
		let label = UILabel()
		return label
	}()

	/// The table view.
	let tableView: UITableView = {
		let tableView = UITableView()
		return tableView
	}()

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
