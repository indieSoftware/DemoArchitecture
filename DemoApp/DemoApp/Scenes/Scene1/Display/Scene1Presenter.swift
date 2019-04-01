import UIKit

/// Responsible for updating the view according to the data to present.
final class Scene1Presenter {
	/// A weak reference to the view controller for changing UIKit representation.
	/// Has to be assigned via property injection after initializing.
	weak var viewController: UIViewController?

	/// A weak reference to the view responsible for.
	/// Needs to be assigned by the view controller when the view gets created.
	weak var view: Scene1View?

	/// A weak reference to the table controller.
	/// Needs to be assigned by the view controller when the view gets created.
	weak var tableController: Scene1TableControllerInterface?
}

// MARK: - Scene1PresenterInterface

extension Scene1Presenter: Scene1PresenterInterface {
	func updateView(model: Scene1PresenterModel.UpdateView) {
		// Update the nav bar title.
		viewController?.title = R.string.scene1.title()

		// Show the headline if a value is provided.
		if let headlineValue = model.headlineValue {
			view?.headlineLabel.text = R.string.scene1.headlineWithValue(headlineValue, model.numberOfInfos)
		} else {
			view?.headlineLabel.text = R.string.scene1.headlineNoValue(model.numberOfInfos)
		}

		// Update the table.
		let tableModel = Scene1TableModel.DataModel(
			cellTitles: model.entityTitles
		)
		tableController?.setData(model: tableModel)
	}

	func updateHeadline(model: Scene1PresenterModel.UpdateHeadline) {
		view?.headlineLabel.text = R.string.scene1.headlineWithValue(model.value, model.numberOfInfos)
	}
}
