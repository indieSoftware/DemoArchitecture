import Anchorage
import UIKit

/**
 A base class for table view cells.
 Derive from this class instead of `UITableViewCell` directly.
 Override `configureView` to set up the view hierarchy and layout.
 */
class BaseCell: UITableViewCell {
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		configureView()
	}

	@available(*, unavailable, message: "Instantiating via Xib & Storyboard is prohibited.")
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 Builds up the view hierarchy and applies the layout.
	 Subclasses should override this method to set up the view's content and layout.
	 The method `embedCellView()` might be used for that.
	 The base implementation does nothing.
	 */
	func configureView() {}

	/**
	 Embeds a given cell view into the cell's content view.

	 - parameter cellView: The cell's real view to show.
	 */
	func embedCellView(_ cellView: UIView) {
		contentView.addSubview(cellView)
		cellView.edgeAnchors == contentView.edgeAnchors
	}
}
