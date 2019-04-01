import UIKit

/// The interface for presenting something in the view.
protocol Scene2PresenterInterface: AnyObject {
	/**
	 Updates the whole view according to the given state.

	 - parameter model: The new state.
	 */
	func updateView(model: Scene2PresenterModel.UpdateView)
}

/// The models send to the presenter.
struct Scene2PresenterModel {
	struct UpdateView {
		/// The timestamp of the last update.
		let timestamp: Date
		/// The headline provided to show in the title.
		let headline: String
		/// Whether rotation is locked or not.
		let displayRotation: DisplayRotation
		/// The counter value.
		let counterValue: Int
		/// The current settings version number.
		let settingsVersion: Int
		/// A sub-controller to embed.
		let subController: UIViewController?
	}
}
