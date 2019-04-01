import UIKit

class Scene1TableController: NSObject {
	/// The table view this controller manages.
	private unowned let tableView: UITableView

	/// A reference to the logic to inform about user actions in the table.
	private unowned let logic: Scene1LogicInterface

	/**
	 Initializes the controller via dependency injection.

	 - parameter tableView: The table view this controller manages. Will be referenced as unowned.
	 - parameter logic: The logic to inform about specific actions. Will be referenced as unowned.
	 */
	init(tableView: UITableView, logic: Scene1LogicInterface) {
		self.tableView = tableView
		self.logic = logic
		super.init()

		// Set up table view.
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension

		// Register cells.
		tableView.register(Scene1DefaultCell.self)
	}

	// MARK: - Table content

	/// The data representation for the table view.
	private var tableData = [Scene1TableData]()

	/**
	 Creates the data for the table view.
	 Does not reload the table view itself.

	 - parameter model: The model to use for mapping to the content.
	 */
	private func createTableData(model: Scene1TableModel.DataModel) {
		// Clear data.
		tableData = [Scene1TableData]()

		// Map data.
		let mappedData = model.cellTitles.map { (title) -> Scene1TableData in
			let cellModel = Scene1DefaultCellModel(
				title: title,
				delegate: self
			)
			return Scene1TableData.defaultCell(cellModel)
		}
		tableData += mappedData
	}
}

// MARK: - Scene1TableControllerInterface

extension Scene1TableController: Scene1TableControllerInterface {
	func setData(model: Scene1TableModel.DataModel) {
		createTableData(model: model)
		tableView.reloadData()
		tableView.contentOffset = .zero
	}
}

// MARK: - UITableViewDataSource

extension Scene1TableController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableData.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = tableData[indexPath.row]
		switch data {
		case let .defaultCell(cellModel):
			return defaultCell(model: cellModel)
		}
	}

	// MARK: - Cells

	private func defaultCell(model: Scene1DefaultCellModel) -> Scene1DefaultCell {
		guard let cell = tableView.dequeueReusableCell(for: Scene1DefaultCell.self) else {
			fatalError("No cell available")
		}
		cell.setup(model: model)
		return cell
	}
}

// MARK: - UITableViewDelegate

extension Scene1TableController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		let data = tableData[indexPath.row]
		switch data {
		case let .defaultCell(cellModel):
			logic.entrySelected(title: cellModel.title)
		}
	}
}

// MARK: - Scene1DefaultCellDelegate

extension Scene1TableController: Scene1DefaultCellDelegate {
	func cellButtonPressed(title: String) {
		logic.entryInfoSelected(title: title)
	}
}
