import Shared
import UIKit

class Scene1DefaultCell: BaseCell {
	/// The cell's view to embed into the content view.
	private let cellView = Scene1DefaultCellView()

	override func configureView() {
		embedCellView(cellView)
	}

	// MARK: - Setup

	/// The cell's model.
	private var model: Scene1DefaultCellModel?

	/**
	 Sets up the cell.

	 - parameter model: The cell's model.
	 */
	func setup(model: Scene1DefaultCellModel) {
		// Apply model.
		self.model = model
		cellView.titleLabel.text = model.title

		// Register for callback actions
		onCellButtonPressed.setDelegate(to: self, with: { _, _ in
			model.delegate?.cellButtonPressed(title: model.title)
		})
	}

	// MARK: - Delegate callers

	private lazy var onCellButtonPressed: ControlCallback<Scene1DefaultCell> = {
		ControlCallback(for: cellView.cellButton, event: .touchUpInside) { [unowned self] in
			self
		}
	}()
}
