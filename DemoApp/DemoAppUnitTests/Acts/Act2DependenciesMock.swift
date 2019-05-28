@testable import DemoAppDev
import ServerWorker
import Shared
import XCTest

class Act2DependenciesMock: Act2DependenciesInterface {
	var serverWorkerStub: () -> ServerWorkerInterface = { XCTFail(); return ServerWorkerMock() }
	var serverWorker: ServerWorkerInterface {
		return serverWorkerStub()
	}

	var userStub: () -> User = { XCTFail(); return User() }
	var user: User {
		return userStub()
	}

	var sceneStub: (_ scene: Act2Scene) -> UIViewController = { _ in XCTFail(); return UIViewController() }
	func scene(_ scene: Act2Scene) -> UIViewController {
		return sceneStub(scene)
	}
}
