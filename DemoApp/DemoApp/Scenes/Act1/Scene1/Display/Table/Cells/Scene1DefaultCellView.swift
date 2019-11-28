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
		cellButton.horizontalHuggingPriority = .low + 1
		cellButton.horizontalCompressionResistance = .high + 1

		// Add the separator line to the bottom.
		addSubview(separatorLine)
		separatorLine.bottomAnchor == bottomAnchor
		separatorLine.leadingAnchor == leadingAnchor
		separatorLine.trailingAnchor == trailingAnchor
		separatorLine.heightAnchor == Const.Size.separatorThickness

		// The view's min height.
		heightAnchor == Const.Size.cellMinHeight ~ .required - 1

		// Set default styles.
		backgroundColor = Const.Color.defaultBackground()
		directionalLayoutMargins = Const.Margin.cell.directional
	}

	// MARK: - Subviews

	/// The label for displaying the title.
	let titleLabel: UILabel = {
		let label = UILabel()
		return label
	}()

	/// The button to apply the suggestion.
	let cellButton: UIButton = {
		let button = UIButton(type: UIButton.ButtonType.contactAdd)
		return button
	}()

	/// The separator line.
	let separatorLine: UIView = {
		let color = Const.Color.separator()
		let line = UIView.viewWithColor(color)
		return line
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
