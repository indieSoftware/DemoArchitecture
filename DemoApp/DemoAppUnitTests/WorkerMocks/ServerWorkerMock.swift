@testable import DemoAppDev
import ServerWorker
import Shared
import XCTest

/// A ServerWorker replacement for mocking this dependency during tests.
class ServerWorkerMock: ServerWorkerInterface {
	var sendStub: (_ request: Request.SearchAutocompletion.Query, _ completion: @escaping (Result<Request.SearchAutocompletion.Query.Response, ServerWorkerError>) -> Void) -> Void = { _, _ in XCTFail() }

	func send<T>(_ request: T, completion: @escaping (Result<T.Response, ServerWorkerError>) -> Void) where T: ServerRequest {
		if let request = request as? Request.SearchAutocompletion.Query, let completion = completion as? (Result<Request.SearchAutocompletion.Query.Response, ServerWorkerError>) -> Void {
			sendStub(request, completion)
		} else {
			XCTFail("Undefined request type")
		}
	}
}
