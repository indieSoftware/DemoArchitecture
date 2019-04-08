import Hippolyte
@testable import ServerWorker
@testable import Shared
import XCTest

class SearchAutocompletionTests: XCTestCase {
	/// The subject under test.
	private var sut: ServerWorker!
	/// A weak reference to the sut for detecting retain cycles.
	private weak var weakSut: ServerWorker?

	override func setUp() {
		sut = ServerWorker()
		weakSut = sut
	}

	override func tearDown() {
		Hippolyte.shared.stop() // Stop endpoint stubbing
		sut = nil
		XCTAssertNil(weakSut, "ServerWorker has a retain cycle")
	}

	// MARK: - Tests

	/// The endpoint URL is composed correctly.
	func testEndpointMatch() {
		let query = "testEndpointMatch"
		let request = Request.SearchAutocompletion.Query(query)
		let expectedUrl = URL(string: sut.baseEndpointUrl.appendingPathComponent(request.resourceName).absoluteString +
			"?\(Request.SearchAutocompletion.Query.CodingKeys.language.rawValue)=\(request.language)" +
			"&\(Request.SearchAutocompletion.Query.CodingKeys.output.rawValue)=\(request.output)" +
			"&\(Request.SearchAutocompletion.Query.CodingKeys.query.rawValue)=\(request.query)")!

		// Call method under test.
		let returnedEndpoint = sut.endpoint(for: request)

		// Compare result with expectations.
		XCTAssertEqual(expectedUrl, returnedEndpoint)
	}

	/// An empty suggestions object is returned.
	func testNoSuggestionResult() {
		let suggestions = Suggestions([])
		performPositiveTest(query: "testNoSuggestionResult", suggestions: suggestions)
	}

	/// A single suggestion object is returned.
	func testSingleSuggestionResult() {
		let suggestions = Suggestions([Suggestion("Sug1")])
		performPositiveTest(query: "testSingleSuggestionResult", suggestions: suggestions)
	}

	/// Multiple suggestion objects are returned.
	func testMultipleSuggestionResults() {
		let suggestions = Suggestions([Suggestion("Sug1"), Suggestion("Sug2")])
		performPositiveTest(query: "testMultipleSuggestionResults", suggestions: suggestions)
	}

	/// A query with space characters in it is accepted.
	func testQueryWithSpaces() {
		let suggestions = Suggestions([Suggestion("Sug")])
		performPositiveTest(query: "test Query With Spaces", suggestions: suggestions)
	}

	/// The returned object couldn't be decoded.
	func testDecodingError() {
		let request = createRequestAndMissmatchingEndpoint(query: "testDecodingError")

		// Call method under test.
		let sendResultExpectation = expectation(description: "sendResultExpectation")
		sut.send(request) { result in
			guard case .failure(.decoding) = result else {
				XCTFail("No decoding error returned: \(result)")
				return
			}
			sendResultExpectation.fulfill()
		}

		// Wait for the async work to end.
		waitForExpectations(timeout: 1.0)
	}

	/// The server returns a bad status code.
	func testServerError() {
		let request = createRequestAndBadEndpoint(query: "testServerError")

		// Call method under test.
		let sendResultExpectation = expectation(description: "sendResultExpectation")
		sut.send(request) { result in
			guard case .failure(.server) = result else {
				XCTFail("No server error returned: \(result)")
				return
			}
			sendResultExpectation.fulfill()
		}

		// Wait for the async work to end.
		waitForExpectations(timeout: 1.0)
	}

	// MARK: - Helper

	/**
	 Prepares a new request and starts an endpoint stub for that request.

	 - parameter query: The query string for the request.
	 - parameter resultData: The data returned when querying the request's endpoint.
	 - returns: The created request.
	 */
	private func createRequestAndEndpoint(query: String, resultData: Data) -> Request.SearchAutocompletion.Query {
		var response = StubResponse()
		response.body = resultData
		let request = Request.SearchAutocompletion.Query(query)
		let url = sut.endpoint(for: request)
		var stub = StubRequest(method: .GET, url: url)
		stub.response = response
		Hippolyte.shared.add(stubbedRequest: stub)
		Hippolyte.shared.start()
		return request
	}

	/**
	 Prepares a new request and starts an endpoint stub for that request returning suggestions.

	 - parameter query: The query string for the request.
	 - parameter result: The result object returned by the server stub.
	 - returns: The created request.
	 */
	private func createRequestAndEndpoint(query: String, result: SearchAutocompletionResult) -> Request.SearchAutocompletion.Query {
		let jsonResult = try! JSONEncoder().encode(result)
		return createRequestAndEndpoint(query: query, resultData: jsonResult)
	}

	/**
	 Prepares a new request and starts an endpoint stub which doesn't return a valid suggestions object.

	 - parameter query: The query string for the request.
	 - returns: The created request.
	 */
	private func createRequestAndMissmatchingEndpoint(query: String) -> Request.SearchAutocompletion.Query {
		let jsonResult = try! JSONEncoder().encode(["Undefined": "NoResultObject"])
		return createRequestAndEndpoint(query: query, resultData: jsonResult)
	}

	/**
	  Prepares a new request and starts an endpoint stub which returns a 404 status code instead of some data.

	 - parameter query: The query string for the request.
	  - returns: The created request.
	 */
	private func createRequestAndBadEndpoint(query: String) -> Request.SearchAutocompletion.Query {
		let request = Request.SearchAutocompletion.Query(query)
		let url = sut.endpoint(for: request)
		var stub = StubRequest(method: .GET, url: url)
		stub.response = StubResponse(statusCode: 404)
		Hippolyte.shared.add(stubbedRequest: stub)
		Hippolyte.shared.start()
		return request
	}

	/**
	 Encapsulates common test code for a positive result where the request returns valid data back.

	 Fails if the request sent couldn't get the suggestions object back from the stub.

	 - parameter query: The search query.
	 - parameter suggestions: The suggestions object returned for the test.
	 */
	private func performPositiveTest(query: String, suggestions: Suggestions) {
		let expectedResultValue = SearchAutocompletionResult(query: query, suggestions: suggestions)
		let request = createRequestAndEndpoint(query: query, result: expectedResultValue)

		// Call method under test.
		let sendResultExpectation = expectation(description: "sendResultExpectation")
		sut.send(request) { result in
			guard case let .success(resultValue) = result else {
				XCTFail("No success returned: \(result)")
				return
			}
			XCTAssertEqual(expectedResultValue, resultValue)
			sendResultExpectation.fulfill()
		}

		// Wait for the async work to end.
		waitForExpectations(timeout: 1.0)
	}
}
