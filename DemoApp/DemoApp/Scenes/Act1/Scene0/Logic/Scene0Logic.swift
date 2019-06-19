import Foundation

extension Scene0Model {
	/// The dependencies for the logic to inject.
	struct LogicDependencies {
		let setupModel: SetupModel.Scene0
		let presenter: Scene0PresenterInterface
		let navigator: Scene0NavigatorInterface
		let actDependencies: Act1DCInterface
	}
}

/**
 The business logic for this scene.
 This class is responsible for any logic happening in the scene.
 */
final class Scene0Logic {
	/// The data model holding the current scene's logic state.
	private(set) var state = Scene0Model.LogicState()

	/// The injected dependencies.
	private let dependencies: Scene0Model.LogicDependencies

	required init(dependencies: Scene0Model.LogicDependencies) {
		self.dependencies = dependencies
	}
}

// MARK: - Scene0LogicInterface

extension Scene0Logic: Scene0LogicInterface {
	func start() {
		dependencies.presenter.showSplash {}

		let internalSettings = dependencies.actDependencies.settings
		internalSettings.updateSettings(testScenario: nil)

		let model = SetupModel.Scene1()
		dependencies.navigator.scene1(setupModel: model)
	}
}
