import Shared

/// The model for `Scene1DefaultCell`.
struct Scene1DefaultCellModel {
	/// The represented data.
	let suggestion: Suggestion
	/// The cell's delegate to inform about actions inside of the cell.
	weak var delegate: Scene1DefaultCellDelegate?
}

protocol Scene1DefaultCellDelegate: AnyObject {
	/**
	 Informs that the cell button has been pressed.

	 - parameter cellModel: The cell's model.
	 */
	func cellButtonPressed(cellModel: Scene1DefaultCellModel)
}
