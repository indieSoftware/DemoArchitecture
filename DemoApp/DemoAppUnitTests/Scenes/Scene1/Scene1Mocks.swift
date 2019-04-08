@testable import DemoAppDev
import ServerWorker
@testable import Shared
import XCTest

class Scene1LogicDependencyMock: Scene1LogicDependencyResolver {
	var setupModel = Scene1Setup()

	var _serverWorker = ServerWorkerMock()
	var serverWorker: ServerWorkerInterface { return _serverWorker }

	var _presenter = Scene1PresenterMock()
	var presenter: Scene1PresenterInterface { return _presenter }

	var _navigator = Scene1NavigatorMock()
	var navigator: Scene1NavigatorInterface { return _navigator }
}

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
	var scene2SetupModel: (_ setupModel: Scene2Setup) -> Void = { _ in XCTFail() }
	func scene2(setupModel: Scene2Setup) {
		scene2SetupModel(setupModel)
	}
}
