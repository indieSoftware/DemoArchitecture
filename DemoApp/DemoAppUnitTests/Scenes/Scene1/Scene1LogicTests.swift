@testable import DemoAppDev
import ServerWorker
@testable import Shared
import XCTest

class Scene1LogicTests: XCTestCase {
	/// The subject under test.
	private var sut: Scene1Logic!
	/// A weak reference to the sut for detecting retain cycles.
	private weak var weakSut: Scene1Logic?
	/// The dependencies injected for testing.
	private var presenterMock: Scene1PresenterMock!
	private var navigatorMock: Scene1NavigatorMock!
	private var actDependenciesMock: Act1DependenciesMock!

	func createSut(setupModel: SetupModel.Scene1) {
		presenterMock = Scene1PresenterMock()
		navigatorMock = Scene1NavigatorMock()
		actDependenciesMock = Act1DependenciesMock()
		let logicDependencies = Scene1Model.LogicDependencies(
			setupModel: setupModel,
			presenter: presenterMock,
			navigator: navigatorMock,
			actDependencies: actDependenciesMock
		)
		sut = Scene1Logic(dependencies: logicDependencies)
		weakSut = sut
	}

	override func tearDown() {
		sut = nil
		XCTAssertNil(weakSut, "Logic has a retain cycle")
	}

	// MARK: - Tests

	// MARK: updateInitialDisplay()

	/// The server gets queried and the result delivered to the display.
	func testUpdateInitialDisplay() {
		let setupModel = SetupModel.Scene1()
		createSut(setupModel: setupModel)

		// Expect behavior.
		expectPresenterGetsSuggestionList(suggestions: Suggestions([]))

		// Method under test.
		sut.updateInitialDisplay()

		// Wait for the async work to end.
		waitForExpectations(timeout: 1.0)
	}

	// MARK: displayRotated()

	/// The rotation counter gets incremented each time.
	func testDisplayRotatedIncrementsCounter() {
		let setupModel = SetupModel.Scene1()
		createSut(setupModel: setupModel)

		// Counter should start with 0.
		XCTAssertEqual(0, sut.state.numberOfRotations)

		for loopNumber in 1 ... 10 {
			// Method under text.
			sut.displayRotated()

			// The counter should now be incremented.
			XCTAssertEqual(loopNumber, sut.state.numberOfRotations)
		}
	}

	// MARK: searchForText(_ text: String)

	/// Searched for an empty string.
	func testSearchForEmptyText() {
		let setupModel = SetupModel.Scene1()
		createSut(setupModel: setupModel)

		// Expect behavior.
		expectPresenterGetsSuggestionList(suggestions: Suggestions([]))

		// Method under test.
		sut.searchForText(String.empty)

		// Wait for the async work to end.
		waitForExpectations(timeout: 1.0)
	}

	/// Searched for a string.
	func testSearchForSomeText() {
		let searchText = "Some"
		let expectedResult = Suggestions([Suggestion("ATerm")])
		performSearchForTextTest(searchText: searchText, expectedResult: expectedResult)
	}

	/// Searched for a string with space character in it.
	func testSearchWithSpaces() {
		let searchText = "Special Text"
		let expectedResult = Suggestions([Suggestion("Result")])
		performSearchForTextTest(searchText: searchText, expectedResult: expectedResult)
	}

	/**
	 Encapsulates common test code for a search with text.

	 - parameter searchText: The search string.
	 - parameter expectedResult: The results for the search.
	 */
	private func performSearchForTextTest(searchText: String, expectedResult: Suggestions) {
		let setupModel = SetupModel.Scene1()
		createSut(setupModel: setupModel)

		// Expect behavior.
		expectServerSendsSuggestions(queryString: searchText, suggestions: expectedResult)
		expectPresenterGetsSuggestionList(suggestions: expectedResult)

		// Method under test.
		sut.searchForText(searchText)

		// Wait for the async work to end.
		waitForExpectations(timeout: 1.0)
	}

	/// Search returns a server error.
	func testSearchFailedWithServerError() {
		let expectedError = ServerWorkerError.server
		performSearchWithError(expectedError: expectedError)
	}

	/// Search returns a decoding error.
	func testSearchFailedWithDecodingError() {
		let expectedError = ServerWorkerError.decoding
		performSearchWithError(expectedError: expectedError)
	}

	/**
	 Encapsulates common test code for an erronous search.

	 - parameter expectedError: The error to return.
	 */
	private func performSearchWithError(expectedError: ServerWorkerError) {
		let setupModel = SetupModel.Scene1()
		createSut(setupModel: setupModel)

		let searchText = "SomeText"

		// Expect behavior.
		expectServerSendsError(expectedError: expectedError)
		expectPresenterGetsError(expectedError: expectedError)

		// Method under test.
		sut.searchForText(searchText)

		// Wait for the async work to end.
		waitForExpectations(timeout: 1.0)
	}

	// MARK: dismissKeyboard()

	/// Undefined.
	func testDismissKeyboard() {
		// Not tested.
	}

	// MARK: applySuggestion(_ suggestion: Suggestion)

	/// Apply a suggestion and get a new one delivered.
	func testApplySuggestion() {
		let setupModel = SetupModel.Scene1()
		createSut(setupModel: setupModel)

		let suggestion = Suggestion("Term")
		let newSuggestions = Suggestions([Suggestion("Different")])

		// Expect behavior.
		expectPresenterGetsSearchText(searchText: suggestion)
		expectServerSendsSuggestions(queryString: suggestion, suggestions: newSuggestions)
		expectPresenterGetsSuggestionList(suggestions: newSuggestions)

		// Method under test.
		sut.adoptSuggestion(suggestion)

		// Wait for the async work to end.
		waitForExpectations(timeout: 1.0)
	}

	// MARK: showSuggestionDetails(_ suggestion: Suggestion)

	/// The navigator is instructed to show the scene.
	func testNavigatorGetsInstructed() {
		let setupModel = SetupModel.Scene1()
		createSut(setupModel: setupModel)

		let suggestionTerm = "suggestion term"
		let suggestion = Suggestion(suggestionTerm)

		// Prepare navigation mock.
		let navigatorExpectation = expectation(description: "navigatorExpectation")
		navigatorMock.scene2SetupModel = { setupModel, _ in
			XCTAssertEqual(suggestionTerm, setupModel.headline)
			XCTAssertEqual(0, setupModel.numberOfRotations)
			navigatorExpectation.fulfill()
		}

		// Method under text.
		sut.showSuggestionDetails(suggestion)

		waitForExpectations(timeout: 1.0)
	}

	/// The callback value from the other scene is used.
	func testCallbackValueRespected() {
		let setupModel = SetupModel.Scene1()
		createSut(setupModel: setupModel)

		let suggestionTerm = "term"
		let suggestion = Suggestion(suggestionTerm)

		// Prepare navigation mock.
		let navigatorExpectation = expectation(description: "navigatorExpectation")
		navigatorMock.scene2SetupModel = { setupModel, _ in
			let callbackResult = SetupModel.Scene2Result(numberOfRotations: 3)
			setupModel.callback(callbackResult)
			navigatorExpectation.fulfill()
		}

		// Ensure the counter is zero.
		XCTAssertEqual(0, sut.state.numberOfRotations)

		// Method under text.
		sut.showSuggestionDetails(suggestion)

		waitForExpectations(timeout: 1.0)
		XCTAssertEqual(3, sut.state.numberOfRotations)
	}

	// MARK: - Helper

	/**
	 Creates a test expectation:
	 The server worker returns a success with the given suggestions.

	 - parameter queryString: The request's search string.
	 - parameter suggestions: The api's return value.
	 */
	private func expectServerSendsSuggestions(queryString: String, suggestions: Suggestions) {
		let serverWorkerMock = ServerWorkerMock()
		actDependenciesMock.serverWorkerStub = { serverWorkerMock }

		let result = SearchAutocompletionResult(query: queryString, suggestions: suggestions)
		let sendExpectation = expectation(description: "expectServerSendsSuggestionsExpectation")
		serverWorkerMock.sendStub = { _, closure in
			sendExpectation.fulfill()
			closure(.success(result))
		}
	}

	/**
	 Creates a test expectation:
	 The server worker returns a failure with the given error.

	 - parameter expectedError: The returned error.
	 */
	private func expectServerSendsError(expectedError: ServerWorkerError) {
		let serverWorkerMock = ServerWorkerMock()
		actDependenciesMock.serverWorkerStub = { serverWorkerMock }

		let sendExpectation = expectation(description: "expectServerSendsErrorExpectation")
		serverWorkerMock.sendStub = { _, closure in
			sendExpectation.fulfill()
			closure(.failure(expectedError))
		}
	}

	/**
	 Creates a test expectation:
	 The presenter gets the search text updated.

	 - parameter searchText: The new search string.
	 */
	private func expectPresenterGetsSearchText(searchText: String) {
		let searchTextExpectation = expectation(description: "expectPresenterGetsSearchTextExpectation")
		presenterMock.searchTextStub = { text in
			searchTextExpectation.fulfill()
			XCTAssertEqual(text, searchText)
		}
	}

	/**
	 Creates a test expectation:
	 The presenter gets a server error message.

	 - parameter expectedError: The error provided.
	 */
	private func expectPresenterGetsError(expectedError: ServerWorkerError) {
		let presenterExpectation = expectation(description: "expectPresenterGetsErrorExpectation")
		presenterMock.serverErrorStub = { error in
			presenterExpectation.fulfill()
			XCTAssertEqual(error, expectedError)
		}
	}

	/**
	 Creates a test expectation:
	 The presenter gets a new suggestion list delivered.

	 - parameter suggestions: The suggestions expected.
	 */
	private func expectPresenterGetsSuggestionList(suggestions: Suggestions) {
		let presenterExpectation = expectation(description: "expectPresenterGetsSuggestionListExpectation")
		presenterMock.suggestionListStub = { result in
			presenterExpectation.fulfill()
			XCTAssertEqual(result, suggestions)
		}
	}
}
