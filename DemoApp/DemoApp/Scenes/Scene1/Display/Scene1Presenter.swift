import ServerWorker
import Shared
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
	func suggestionList(suggestions: Suggestions) {
		let tableModel = Scene1TableModel.DataModel(suggestions: suggestions)
		tableController?.setData(model: tableModel)
	}

	func serverError(_ error: ServerWorkerError) {
		let alert = UIAlertController(title: R.string.global.serverErrorTitle(), message: R.string.global.serverErrorMessage(), preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: R.string.global.serverErrorDefaultButton(), style: .default, handler: nil)
		alert.addAction(defaultAction)
		viewController?.present(alert, animated: true, completion: nil)
	}

	func searchText(_ text: String) {
		view?.searchInputField.text = text
	}
}
