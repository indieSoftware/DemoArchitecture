import Foundation

/// The interface for presenting something in the view.
protocol Scene1PresenterInterface: AnyObject {
	/**
	 Updates the whole view according to the given state.

	 - parameter model: The new state.
	 */
	func updateView(model: Scene1PresenterModel.UpdateView)

	/**
	 Updates only the headline for a value.

	 - parameter model: The new state.
	 */
	func updateHeadline(model: Scene1PresenterModel.UpdateHeadline)
}

/// The models send to the presenter.
struct Scene1PresenterModel {
	struct UpdateView {
		/// The headline value to show if any is available.
		let headlineValue: String?
		/// The number of times the info have been requested.
		let numberOfInfos: Int
		/// The list of entities with their titles.
		let entityTitles: [String]
	}

	struct UpdateHeadline {
		/// The headline value to show.
		let value: String
		/// The number to show with the value.
		let numberOfInfos: Int
	}
}
