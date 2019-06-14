@testable import DemoAppDev
import ServerWorker
import Shared
import XCTest

class Act2DCMock: Act2DCInterface {
	var factoryStub: () -> Act2FactoryInterface = { XCTFail(); return Act2FactoryMock() }
	var factory: Act2FactoryInterface {
		return factoryStub()
	}

	var serverWorkerStub: () -> ServerWorkerInterface = { XCTFail(); return ServerWorkerMock() }
	var serverWorker: ServerWorkerInterface {
		return serverWorkerStub()
	}

	var userStub: () -> User = { XCTFail(); return User() }
	var user: User {
		return userStub()
	}
}

class Act2FactoryMock: Act2FactoryInterface {
	var sceneStub: (_ scene: Act2Scene) -> UIViewController = { _ in XCTFail(); return UIViewController() }
	func scene(_ scene: Act2Scene) -> UIViewController {
		return sceneStub(scene)
	}
}
