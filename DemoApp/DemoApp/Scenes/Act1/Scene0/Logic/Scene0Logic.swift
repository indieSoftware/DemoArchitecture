import Foundation
import Shared

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
		// Hold a strong reference to the dependencies for the closures.
		let dependencies = self.dependencies

		// Don't block the main thread with the following tasks.
		DispatchQueue.global(qos: .background).async {
			let dispatchGroup = DispatchGroup()
			let testFlags = dependencies.actDependencies.configuration.testFlags

			// Start updating the settings in its own background block.
			dispatchGroup.enter()
			DispatchQueue.global(qos: .background).async {
				dependencies.actDependencies.settings.updateSettings(testFlags: testFlags)
				dispatchGroup.leave()
			}

			// If not the fast start test scenario is set then simply wait
			// to make sure the splash is shown the minimum time.
			if testFlags?.noSplash ?? false {
				Thread.sleep(forTimeInterval: Const.Time.splashMinShowDuration)
			}

			// Wait further for the settings update group to complete if necessary.
			dispatchGroup.wait()

			// Run any presenter and navigator methods on the main thread.
			DispatchQueue.main.async {
				if testFlags?.noSplash ?? false {
					// Fast start test scenario, skip splash hiding and start transition immediately.
					let model = SetupModel.Scene1()
					dependencies.navigator.scene1(setupModel: model)
				} else {
					// Normal mode, hide splash.
					dependencies.presenter.hideSplash {
						// Start transition after hiding the splash.
						let model = SetupModel.Scene1()
						dependencies.navigator.scene1(setupModel: model)
					}
				}
			}
		}
	}
}
