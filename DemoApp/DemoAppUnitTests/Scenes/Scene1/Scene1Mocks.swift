@testable import DemoAppDev
import ServerWorker
import Shared
import XCTest

class Scene1PresenterMock: Scene1PresenterInterface {
	var suggestionListStub: (_ suggestions: Suggestions) -> Void = { _ in XCTFail() }
	func suggestionList(suggestions: Suggestions) {
		suggestionListStub(suggestions)
	}

	var serverErrorStub: (_ error: ServerWorkerError) -> Void = { _ in XCTFail() }
	func serverError(_ error: ServerWorkerError) {
		serverErrorStub(error)
	}

	var searchTextStub: (_ text: String) -> Void = { _ in XCTFail() }
	func searchText(_ text: String) {
		searchTextStub(text)
	}
}

class Scene1NavigatorMock: Scene1NavigatorInterface {
	var scene2SetupModel: (_ setupModel: SetupModel.Scene2, _ user: User) -> Void = { _, _ in XCTFail() }
	func scene2(setupModel: SetupModel.Scene2, user: User) {
		scene2SetupModel(setupModel, user)
	}
}
