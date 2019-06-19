import Foundation

extension ___VARIABLE_sceneName___Model {
	/// The dependencies for the logic to inject.
	struct LogicDependencies {
		let setupModel: SetupModel.___VARIABLE_sceneName___
		let presenter: ___VARIABLE_sceneName___PresenterInterface
		let navigator: ___VARIABLE_sceneName___NavigatorInterface
		let actDependencies: ___VARIABLE_actName___DCInterface
	}
}

/**
 The business logic for this scene.
 This class is responsible for any logic happening in the scene.
 */
final class ___VARIABLE_sceneName___Logic {
	/// The data model holding the current scene's logic state.
	private(set) var state = ___VARIABLE_sceneName___Model.LogicState()

	/// The injected dependencies.
	private let dependencies: ___VARIABLE_sceneName___Model.LogicDependencies

	required init(dependencies: ___VARIABLE_sceneName___Model.LogicDependencies) {
		self.dependencies = dependencies
	}
}

// MARK: - ___VARIABLE_sceneName___LogicInterface

extension ___VARIABLE_sceneName___Logic: ___VARIABLE_sceneName___LogicInterface {
	func updateDisplay() {
		let model = ___VARIABLE_sceneName___Model.Presenter.UpdateView()
		dependencies.presenter.updateView(model: model)
	}

    func updateParentScene() {
        let model = SetupModel.___VARIABLE_sceneName___Result()
        dependencies.setupModel.callback(model)
    }
}
