/// The model for `Scene1DefaultCell`.
struct Scene1DefaultCellModel {
	/// The cell's title.
	let title: String
	/// The cell's delegate to inform about actions inside of the cell.
	weak var delegate: Scene1DefaultCellDelegate?
}

protocol Scene1DefaultCellDelegate: AnyObject {
	/**
	 Informs that the cell button has been pressed.

	 - parameter title: The cell's title.
	 */
	func cellButtonPressed(title: String)
}
