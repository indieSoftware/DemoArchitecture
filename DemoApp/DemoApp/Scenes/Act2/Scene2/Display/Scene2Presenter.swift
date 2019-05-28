import Shared
import UIKit

/// Responsible for updating the view according to the data to present.
final class Scene2Presenter {
	/// A weak reference to the view controller for changing UIKit representation.
	/// Has to be assigned via property injection after initializing.
	weak var viewController: UIViewController?

	/// A weak reference to the view responsible for.
	/// Needs to be assigned by the view controller when the view gets created.
	weak var view: Scene2View?
}

// MARK: - Scene2PresenterInterface

extension Scene2Presenter: Scene2PresenterInterface {
	func updateView(model: Scene2Model.Presenter.UpdateView) {
		// Update the nav bar title.
		viewController?.title = R.string.scene2.title(model.headline)

		// Format the input data to display the headline.
		let headline: String
		switch model.displayRotation {
		case .locked:
			headline = R.string.scene2.headlineLocked(model.rotations)
			view?.rotationLockSwitch.isOn = true
		case .possible:
			headline = R.string.scene2.headlineUnlocked(model.rotations)
			view?.rotationLockSwitch.isOn = false
		}
		view?.headlineLabel.text = headline

		// Add an embedded sub-view with its own controller if not yet done.
		if let viewController = viewController,
			let subController = model.subController,
			viewController.children.isEmpty {
			viewController.addChild(viewController: subController) {
				view?.addEmbeddedView(subController.view)
			}
		}
	}
}
