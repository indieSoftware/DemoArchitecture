@testable import DemoAppDev
import ServerWorker
import Shared
import XCTest

class Act1DCMock: Act1DCInterface {
	var factoryStub: () -> Act1FactoryInterface = { XCTFail(); return Act1FactoryMock() }
	var factory: Act1FactoryInterface {
		return factoryStub()
	}

	var settingsStub: () -> InternalSettingsInterface = { XCTFail(); return InternalSettingsMock() }
	var settings: InternalSettingsInterface {
		return settingsStub()
	}

	var serverWorkerStub: () -> ServerWorkerInterface = { XCTFail(); return ServerWorkerMock() }
	var serverWorker: ServerWorkerInterface {
		return serverWorkerStub()
	}
}

class Act1FactoryMock: Act1FactoryInterface {
	var sceneStub: (_ scene: Act1Scene) -> UIViewController = { _ in XCTFail(); return UIViewController() }
	func scene(_ scene: Act1Scene) -> UIViewController {
		return sceneStub(scene)
	}

	var act2DCStub: (_ user: User) -> Act2DCInterface = { _ in XCTFail(); return Act2DCMock() }
	func act2DC(user: User) -> Act2DCInterface {
		return act2DCStub(user)
	}
}
