import Shared
import UIKit

/// Responsible for updating the view according to the data to present.
final class Scene0Presenter {
	/// A weak reference to the view controller for changing UIKit representation.
	/// Has to be assigned via property injection after initializing.
	weak var viewController: UIViewController?

	/// A weak reference to the view responsible for.
	/// Needs to be assigned by the view controller when the view gets created.
	weak var view: Scene0View?
}

// MARK: - Scene0PresenterInterface

extension Scene0Presenter: Scene0PresenterInterface {
	func hideSplash(completion: @escaping () -> Void) {
		guard let view = view else { return }

		view.titleLabel.alpha = 1
		UIView.animate(withDuration: Const.Time.splashFadeDuration.timeInterval, animations: {
			view.titleLabel.alpha = 0
		}, completion: { _ in
			completion()
		})
	}
}
