import UIKit

/// The navigator for this scene.
final class Scene0Navigator {
	/// A weak reference to the scene's view controller this router performs transitions on.
	/// Has to be assigned via property injection after initialization.
	weak var viewController: UIViewController?

	/// A reference to the dependency container.
	private let dependencies: Act1DCInterface

	init(dependencies: Act1DCInterface) {
		self.dependencies = dependencies
	}
}

// MARK: - Scene0NavigatorInterface

extension Scene0Navigator: Scene0NavigatorInterface {
	func scene1(setupModel: SetupModel.Scene1) {
		guard let source = viewController else { return }

		let sceneType = Act1Scene.scene1(setupModel)
		let destination = dependencies.factory.scene(sceneType)
		let navController = BaseNavigationController(rootViewController: destination)
		navController.isNavigationBarHidden = true
		navController.modalPresentationStyle = .fullScreen
		source.present(navController, animated: false)
	}
}
