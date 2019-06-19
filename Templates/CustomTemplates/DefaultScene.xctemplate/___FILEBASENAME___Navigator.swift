import UIKit

/// The navigator for this scene.
final class ___VARIABLE_sceneName___Navigator {
	/// A weak reference to the scene's view controller this router performs transitions on.
	/// Has to be assigned via property injection after initialization.
	weak var viewController: UIViewController?

	/// A reference to the dependency container.
	private let dependencies: ___VARIABLE_actName___DCInterface

	init(dependencies: ___VARIABLE_actName___DCInterface) {
		self.dependencies = dependencies
	}
}

// MARK: - ___VARIABLE_sceneName___NavigatorInterface

extension ___VARIABLE_sceneName___Navigator: ___VARIABLE_sceneName___NavigatorInterface {
}
