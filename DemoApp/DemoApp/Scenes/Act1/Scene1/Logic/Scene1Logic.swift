import Foundation
import ServerWorker
import Shared

extension Scene1Model {
	/// The dependencies for the logic to inject.
	struct LogicDependencies {
		let setupModel: SetupModel.Scene1
		let presenter: Scene1PresenterInterface
		let navigator: Scene1NavigatorInterface
		let actDependencies: Act1DCInterface
	}
}

/**
 The business logic for this scene.
 This class is responsible for any logic happening in the scene.
 */
final class Scene1Logic {
	/// The data model holding the current scene's logic state.
	private(set) var state = Scene1Model.LogicState()

	/// The injected dependencies.
	private let dependencies: Scene1Model.LogicDependencies

	required init(dependencies: Scene1Model.LogicDependencies) {
		self.dependencies = dependencies
	}
}

// MARK: - Scene1LogicInterface

extension Scene1Logic: Scene1LogicInterface {
	func updateInitialDisplay() {
		searchForText(String.empty)
	}

	func displayRotated() {
		state.numberOfRotations += 1
	}

	func searchForText(_ text: String) {
		guard !text.isEmpty else {
			// Clear suggestions on empty search text because the server doesn't allow requests with an empty query.
			state.lastSuggestions = []
			dependencies.presenter.suggestionList(suggestions: [])
			return
		}

		// Send non-empty query to server.
		let request = Request.SearchAutocompletion.Query(text)
		dependencies.actDependencies.serverWorker.send(request) { [weak self] result in
			guard let strongSelf = self else { return }
			switch result {
			case let .failure(error):
				strongSelf.dependencies.presenter.serverError(error)
			case let .success(result):
				strongSelf.state.lastSuggestions = result.suggestions
				strongSelf.dependencies.presenter.suggestionList(suggestions: result.suggestions)
			}
		}
	}

	func dismissKeyboard() {
		UIResponder.resignFirstResponder()
	}

	func adoptSuggestion(_ suggestion: Suggestion) {
		let searchText = suggestion
		dependencies.presenter.searchText(searchText)
		searchForText(searchText)
	}

	func showSuggestionDetails(_ suggestion: Suggestion) {
		let model = SetupModel.Scene2(
			headline: suggestion,
			numberOfRotations: state.numberOfRotations,
			callback: { [weak self] model in
				self?.state.numberOfRotations = model.numberOfRotations
			}
		)
		let user = User() // Simulate user log-in or sort of.
		dependencies.navigator.scene2(setupModel: model, user: user)
	}
}
