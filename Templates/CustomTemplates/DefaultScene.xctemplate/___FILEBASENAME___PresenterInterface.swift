import UIKit

/// The interface for presenting something in the view.
protocol ___VARIABLE_sceneName___PresenterInterface: AnyObject {
	/**
	 Updates the whole view according to the given state.

	 - parameter model: The new state.
	 */
	func updateView(model: ___VARIABLE_sceneName___Model.Presenter.UpdateView)
}

extension ___VARIABLE_sceneName___Model {
	/// The models send to the presenter.
	enum Presenter {
		struct UpdateView {
		}
	}
}
