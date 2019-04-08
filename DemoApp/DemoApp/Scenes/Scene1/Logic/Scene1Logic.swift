import Foundation
import ServerWorker
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

	// A reference to the server worker.
	// weaver: serverWorker <- ServerWorkerInterface

	// The presenter for sending data to display.
	// weaver: presenter <- Scene1PresenterInterface

	// The navigator for routing to other scenes.
	// weaver: navigator <- Scene1NavigatorInterface

	required init(injecting dependencies: Scene1LogicDependencyResolver) {
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
		dependencies.serverWorker.send(request) { [weak self] result in
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
		let model = Scene2Setup(
			headline: suggestion,
			numberOfRotations: state.numberOfRotations,
			callback: { [weak self] model in
				self?.state.numberOfRotations = model.numberOfRotations
			}
		)
		dependencies.navigator.scene2(setupModel: model)
	}
}
