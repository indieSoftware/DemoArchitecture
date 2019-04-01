import Foundation
import Shared

/**
 The business logic for this scene.
 This class is responsible for any logic happening in the scene.
 */
final class Scene1Logic {
	/// The data model holding the current scene's logic state.
	private(set) var state = Scene1LogicState()

	/// The injected dependencies.
	private let dependencies: Scene1LogicDependencyResolver

	// The provided setup data parameter.
	// weaver: setupModel <= Scene1Setup

	// weaver: settings <- InternalSettingsInterface

	// The presenter for sending data to display.
	// weaver: presenter <- Scene1Presenter
	// TODO: replace
	/// weaver: presenter <- Scene1PresenterInterface

	// The navigator for routing to other scenes.
	// weaver: navigator <- Scene1Navigator
	// TODO: replace
	/// weaver: navigator <- Scene1NavigatorInterface

	required init(injecting dependencies: Scene1LogicDependencyResolver) {
		self.dependencies = dependencies
	}
}

// MARK: - Scene1LogicInterface

extension Scene1Logic: Scene1LogicInterface {
	func updateDisplay() {
		let model = Scene1PresenterModel.UpdateView(
			headlineValue: nil,
			numberOfInfos: state.numberOfInfos,
			entityTitles: [
				R.string.scene1.entityTitle1(),
				R.string.scene1.entityTitle2(),
				R.string.scene1.entityTitle3()
			]
		)
		dependencies.presenter.updateView(model: model)
	}

	func updateSettings() {
		guard state.settingsUpdated == false else { return }
		state.settingsUpdated = true

		// Update settings.
		let internalSettings = dependencies.settings
		let testScenario = Const.AppArgument.TestScenario(commandLineArguments: CommandLine.arguments)
		if testScenario != nil {
			Log.info("App started in test mode")
		}
		internalSettings.updateSettings(testScenario: testScenario)
	}

	func entrySelected(title: String) {
		let model = Scene2Setup(
			headline: title,
			counter: state.numberOfInfos,
			callback: { [weak self] model in
				self?.state.numberOfInfos = model.counter
			}
		)
		dependencies.navigator.scene2(setupModel: model)
	}

	func entryInfoSelected(title: String) {
		state.numberOfInfos += 1
		let model = Scene1PresenterModel.UpdateHeadline(
			value: title,
			numberOfInfos: state.numberOfInfos
		)
		dependencies.presenter.updateHeadline(model: model)
	}
}
