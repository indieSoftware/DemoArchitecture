import Anchorage
import Shared
import UIKit

class Scene1DefaultCellView: BaseView {
	override func configureView() {
		super.configureView()

		// Add the title label to fill up the view.
		addSubview(titleLabel)
		titleLabel.topAnchor == layoutMarginsGuide.topAnchor
		titleLabel.leadingAnchor == layoutMarginsGuide.leadingAnchor
		titleLabel.bottomAnchor == layoutMarginsGuide.bottomAnchor

		// Add the button to the right of the label.
		addSubview(cellButton)
		cellButton.trailingAnchor == layoutMarginsGuide.trailingAnchor
		cellButton.centerYAnchor == titleLabel.centerYAnchor

		// Set default styles.
		backgroundColor = R.color.defaultBackground()
		directionalLayoutMargins = Const.Margin.cell.directional
	}

	// MARK: - Subviews

	/// The label for displaying the title.
	let titleLabel: UILabel = {
		let label = UILabel()
		return label
	}()

	/// A button inside of the cell.
	let cellButton: UIButton = {
		let button = UIButton(type: UIButton.ButtonType.infoDark)
		return button
	}()

	// MARK: - Interface Builder

	@IBInspectable private lazy var ibBackgroundColor: UIColor = .white
	@IBInspectable private lazy var ibTitle: String = "Title"

	override func prepareForInterfaceBuilder() {
		// For crash reports look at '~/Library/Logs/DiagnosticReports/'.
		super.prepareForInterfaceBuilder()
		backgroundColor = ibBackgroundColor
		titleLabel.text = ibTitle
	}
}
