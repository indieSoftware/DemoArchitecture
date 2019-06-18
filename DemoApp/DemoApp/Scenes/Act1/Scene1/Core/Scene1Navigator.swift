import UIKit

/// The navigator for this scene.
final class Scene1Navigator {
	/// A weak reference to the scene's view controller this router performs transitions on.
	/// Has to be assigned via property injection after initialization.
	weak var viewController: UIViewController?

	/// A reference to the dependecy container.
	private let dependencies: Act1DCInterface

	init(dependencies: Act1DCInterface) {
		self.dependencies = dependencies
	}
}

// MARK: - Scene1NavigatorInterface

extension Scene1Navigator: Scene1NavigatorInterface {
	func scene2(setupModel: SetupModel.Scene2, user: User) {
		guard let source = viewController else { return }
		guard let navController = source.navigationController else {
			fatalError("Navigation controller not provided")
		}

		let act2Dependencies = dependencies.factory.act2DC(user: user)
		let sceneType = Act2Scene.scene2(setupModel)
		let destination = act2Dependencies.factory.scene(sceneType)
		navController.pushViewController(destination, animated: true)
	}
}
