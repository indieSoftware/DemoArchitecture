@testable import DemoAppDev
import Hippolyte
import XCTest

class APIWorkerTests: XCTestCase {
	private var sut: APIWorker!
	private weak var weakSut: APIWorker?

	override func setUp() {
		sut = APIWorker()
		weakSut = sut
	}

	override func tearDown() {
		Hippolyte.shared.stop()
		sut = nil
		XCTAssertNil(weakSut, "APIWorker has a retain cycle")
	}

	func testSendSuccess() {
		// Mock endpoint.
		let searchQuery = "Foo"
		let request = RequestSearchAutocompletion(query: searchQuery)

		let endpointResult = "{ \"suggestions\": [ { \"term\": \"FooBar\" } ] }"
		let body = endpointResult.data(using: .utf8)
		var response = StubResponse()
		response.body = body
		let url = URL(string: sut.baseEndpointUrl.appendingPathComponent(request.resourceName) .. absoluteString + "?query=\(searchQuery)")!
		var stub = StubRequest(method: .GET, url: url)
		stub.response = response
		Hippolyte.shared.add(stubbedRequest: stub)
		Hippolyte.shared.start()

		// Call method under test.
		let sendResultExpectation = expectation(description: "sendResultExpectation")
		sut.send(request) { result in
			// Expect a result to be returned which should match the endpoint result.
			sendResultExpectation.fulfill()
			guard case let .success(suggestions) = result else {
				XCTFail("No success returned: \(result)")
				return
			}
//			XCTAssertEqual(resultValue, endpointResult)
		}

		// Wait for the expectations to fullfill.
		waitForExpectations(timeout: 1.0)
	}
}
