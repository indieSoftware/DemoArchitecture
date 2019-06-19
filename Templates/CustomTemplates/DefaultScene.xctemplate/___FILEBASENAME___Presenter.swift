import UIKit

/// Responsible for updating the view according to the data to present.
final class ___VARIABLE_sceneName___Presenter {
	/// A weak reference to the view controller for changing UIKit representation.
	/// Has to be assigned via property injection after initializing.
	weak var viewController: UIViewController?

	/// A weak reference to the view responsible for.
	/// Needs to be assigned by the view controller when the view gets created.
	weak var view: ___VARIABLE_sceneName___View?
}

// MARK: - ___VARIABLE_sceneName___PresenterInterface

extension ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresenterInterface {
	func updateView(model: ___VARIABLE_sceneName___Model.Presenter.UpdateView) {
	}
}
