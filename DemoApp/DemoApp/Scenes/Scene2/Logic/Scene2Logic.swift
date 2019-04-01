import Foundation

/**
 The business logic for this scene.
 This class is responsible for any logic happening in the scene.
 */
final class Scene2Logic {
	/// The data model holding the current scene's logic state.
	private(set) var state = Scene2LogicState()

	/// The injected dependencies.
	private let dependencies: Scene2LogicDependencyResolver

	// The provided setup data parameter.
	// weaver: setupModel <= Scene2Setup

	// TODO: add
	/// weaver: settings <- InternalSettingsInterface

	// The presenter for sending data to display.
	// weaver: presenter <- Scene2Presenter
	// TODO: replace
	/// weaver: presenter <- Scene2PresenterInterface

	// The navigator for routing to other scenes.
	// weaver: navigator <- Scene2Navigator
	// TODO: replace
	/// weaver: navigator <- Scene2NavigatorInterface

	required init(injecting dependencies: Scene2LogicDependencyResolver) {
		self.dependencies = dependencies
		state.counter = dependencies.setupModel.counter
	}
}

// MARK: - Scene2LogicInterface

extension Scene2Logic: Scene2LogicInterface {
	func updateDisplay() {
		let timestamp = Date()
		let model = Scene2PresenterModel.UpdateView(
			timestamp: timestamp,
			headline: dependencies.setupModel.headline,
			displayRotation: state.displayRotation,
			counterValue: state.counter,
			settingsVersion: 0, // TODO: use: dependencies.settings.settingsVersion
			subController: dependencies.navigator.subController()
		)
		dependencies.presenter.updateView(model: model)
	}

	func rotationLockChanged(lockState: DisplayRotation) {
		state.displayRotation = lockState
		updateDisplay()
	}

	func resetAndDismiss() {
		state.counter = 0
		dependencies.navigator.scene1()
	}

	func updateParentScene() {
		let model = Scene2CallbackModel(counter: state.counter)
		dependencies.setupModel.callback(model)
	}
}
