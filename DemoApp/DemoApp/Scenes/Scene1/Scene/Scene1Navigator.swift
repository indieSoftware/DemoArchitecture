import UIKit

/// The navigator for this scene.
final class Scene1Navigator {
	/// A weak reference to the scene's view controller this router performs transitions on.
	/// Has to be assigned via property injection after initialization.
	weak var viewController: UIViewController?

	/// The injected dependencies.
	private let dependencies: Scene1NavigatorDependencyResolver

	// weaver: forceGenerate = Bool

	// weaver: scene2VC = Scene2VC
	// weaver: scene2VC.scope = .transient

	required init(injecting dependencies: Scene1NavigatorDependencyResolver) {
		self.dependencies = dependencies
	}
}

// MARK: - Scene1NavigatorInterface

extension Scene1Navigator: Scene1NavigatorInterface {
	func scene2(setupModel: Scene2Setup) {
		guard let sourceCountroller = viewController,
			let navController = sourceCountroller.navigationController
		else {
			fatalError("Source for navigation not provided")
		}

		let destinationController = dependencies.scene2VC(setupModel: setupModel)
		navController.pushViewController(destinationController, animated: true)
	}
}
