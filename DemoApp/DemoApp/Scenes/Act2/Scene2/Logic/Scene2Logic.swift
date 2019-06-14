import Foundation

extension Scene2Model {
	/// The dependencies for the logic to inject.
	struct LogicDependencies {
		let setupModel: SetupModel.Scene2
		let presenter: Scene2PresenterInterface
		let navigator: Scene2NavigatorInterface
		let actDependencies: Act2DCInterface
	}
}

/**
 The business logic for this scene.
 This class is responsible for any logic happening in the scene.
 */
final class Scene2Logic {
	/// The data model holding the current scene's logic state.
	private(set) var state = Scene2Model.LogicState()

	/// The injected dependencies.
	private let dependencies: Scene2Model.LogicDependencies

	required init(dependencies: Scene2Model.LogicDependencies) {
		self.dependencies = dependencies
		state.numberOfRotations = dependencies.setupModel.numberOfRotations
	}
}

// MARK: - Scene2LogicInterface

extension Scene2Logic: Scene2LogicInterface {
	func updateDisplay() {
		let model = Scene2Model.Presenter.UpdateView(
			headline: dependencies.setupModel.headline,
			displayRotation: state.displayRotation,
			rotations: state.numberOfRotations
		)
		dependencies.presenter.updateView(model: model)
	}

	func displayRotated() {
		state.numberOfRotations += 1
		updateDisplay()
	}

	func rotationLockChanged(lockState: Scene2Model.DisplayRotation) {
		state.displayRotation = lockState
		updateDisplay()
	}

	func resetAndDismiss() {
		state.numberOfRotations = 0
		dependencies.navigator.scene1()
	}

	func updateParentScene() {
		let model = SetupModel.Scene2Result(numberOfRotations: state.numberOfRotations)
		dependencies.setupModel.callback(model)
	}
}
