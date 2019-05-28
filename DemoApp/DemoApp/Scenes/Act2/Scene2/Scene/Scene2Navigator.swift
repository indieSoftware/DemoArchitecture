import UIKit

/// The navigator for this scene.
final class Scene2Navigator {
	/// A weak reference to the scene's view controller this router performs transitions on.
	/// Has to be assigned via property injection after initialization.
	weak var viewController: UIViewController?

	/// A reference to the dependecy resolver.
	private let dependencies: Act2DependenciesInterface

	init(dependencies: Act2DependenciesInterface) {
		self.dependencies = dependencies
	}
}

// MARK: - Scene2NavigatorInterface

extension Scene2Navigator: Scene2NavigatorInterface {
	func scene1() {
		guard let sourceCountroller = viewController,
			let navController = sourceCountroller.navigationController
		else {
			fatalError("Source for navigation not provided")
		}

		navController.popViewController(animated: true)
	}

	func subController() -> UIViewController {
		let controller = UIViewController()
		controller.view.backgroundColor = .white
		return controller
	}
}