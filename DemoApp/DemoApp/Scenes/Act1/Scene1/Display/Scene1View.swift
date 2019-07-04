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

		// Position the input field at the top.
		addSubview(searchInputField)
		searchInputField.topAnchor == layoutMarginsGuide.topAnchor
		searchInputField.leadingAnchor == layoutMarginsGuide.leadingAnchor
		searchInputField.trailingAnchor == layoutMarginsGuide.trailingAnchor
		searchInputField.heightAnchor == Const.Scene1.searchFieldHeight

		// Add a separator line between the input field and the table view.
		addSubview(separatorLine)
		separatorLine.topAnchor == searchInputField.bottomAnchor + Const.Size.gap
		separatorLine.leadingAnchor == leadingAnchor
		separatorLine.trailingAnchor == trailingAnchor
		separatorLine.heightAnchor == Const.Size.separatorThickness

		// The table view under the headline.
		addSubview(tableView)
		tableView.topAnchor == separatorLine.bottomAnchor
		tableView.leadingAnchor == leadingAnchor
		tableView.trailingAnchor == trailingAnchor
		tableView.bottomAnchor == bottomAnchor

		// Set default styles.
		backgroundColor = R.color.defaultBackground()
		directionalLayoutMargins = Const.Margin.default.directional
	}

	// MARK: - Subviews

	/// The input field for the search query term.
	let searchInputField: UITextField = {
		let field = UITextField()
		field.backgroundColor = R.color.defaultBackground()
		field.text = String.empty
		field.autocorrectionType = .no
		field.clearButtonMode = .always
		field.clearsOnBeginEditing = false
		field.borderStyle = .roundedRect
		return field
	}()

	/// The separator line between input field and table view.
	let separatorLine: UIView = {
		guard let color = R.color.separator() else { fatalError() }
		let line = UIView.viewWithColor(color)
		return line
	}()

	/// The table view covering most of the view.
	let tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = R.color.defaultBackground()
		return tableView
	}()

	// MARK: - Interface Builder

	@IBInspectable private lazy var ibBackgroundColor: UIColor = .white
	@IBInspectable private lazy var ibHeadlineTitle: String = "Headline title"

	override func prepareForInterfaceBuilder() {
		// For crash reports look at '~/Library/Logs/DiagnosticReports/'.
		super.prepareForInterfaceBuilder()
		backgroundColor = ibBackgroundColor
	}
}
