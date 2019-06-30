@testable import DemoAppDev
import ServerWorker
import Shared
import XCTest

class Act2DCStub: Act2DCInterface {
	var factory: Act2FactoryInterface = Act2FactoryMock()
	var configuration: Configuration = ConfigLoader.getConfig(named: .default)
	var serverWorker: ServerWorkerInterface = ServerWorkerMock()
	var user: User = User()
}

class Act2FactoryMock: Act2FactoryInterface {
	var sceneStub: (_ scene: Act2Scene) -> UIViewController = { _ in XCTFail(); return UIViewController() }
	func scene(_ scene: Act2Scene) -> UIViewController {
		return sceneStub(scene)
	}
}
