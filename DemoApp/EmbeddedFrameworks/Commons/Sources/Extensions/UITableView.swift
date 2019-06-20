import UIKit

extension UITableView {
	/**
	 Registers a table view cell at the table view which uses the class' name as the reuse identifier.

	 - parameter cellClass: The cell's class to register.
	 */
	public func register(_ cellClass: UITableViewCell.Type) {
		register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
	}

	/**
	 Dequeues a cell from the table view using the cell's class name as the reuse identifier.

	 - parameter cellClass: The cell's class.
	 - returns: A table view cell of the provided type if one could be dequeued.
	 */
	public func dequeueReusableCell<T>(for cellClass: T.Type) -> T? where T: UITableViewCell {
		return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
	}
}
