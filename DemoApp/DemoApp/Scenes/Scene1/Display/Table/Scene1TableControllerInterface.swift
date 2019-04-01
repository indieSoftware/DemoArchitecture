import UIKit

/// The interface to the table.
protocol Scene1TableControllerInterface: AnyObject {
	/**
	 Assigns the data model and reloads the table view.

	 - parameter model: The data model.
	 */
	func setData(model: Scene1TableModel.DataModel)
}

/// The models send to the table controller.
struct Scene1TableModel {
	struct DataModel {
		/// The cell titles to show.
		let cellTitles: [String]
	}
}
