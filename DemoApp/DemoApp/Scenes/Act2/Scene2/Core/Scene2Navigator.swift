import UIKit

/// The navigator for this scene.
final class Scene2Navigator {
	/// A weak reference to the scene's view controller this router performs transitions on.
	/// Has to be assigned via property injection after initialization.
	weak var viewController: UIViewController?

	/// A reference to the dependency container.
	private let dependencies: Act2DCInterface

	init(dependencies: Act2DCInterface) {
		self.dependencies = dependencies
	}
}

// MARK: - Scene2NavigatorInterface

extension Scene2Navigator: Scene2NavigatorInterface {
	func scene1() {
		guard let source = viewController else { return }
		guard let navController = source.navigationController else {
			fatalError("Navigation controller not provided")
		}

		navController.popViewController(animated: true)
	}
}
