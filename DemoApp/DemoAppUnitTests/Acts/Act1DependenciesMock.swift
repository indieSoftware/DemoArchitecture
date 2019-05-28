@testable import DemoAppDev
import ServerWorker
import Shared
import XCTest

class Act1DependenciesMock: Act1DependenciesInterface {
	var settingsStub: () -> InternalSettingsInterface = { XCTFail(); return InternalSettingsMock() }
	var settings: InternalSettingsInterface {
		return settingsStub()
	}

	var serverWorkerStub: () -> ServerWorkerInterface = { XCTFail(); return ServerWorkerMock() }
	var serverWorker: ServerWorkerInterface {
		return serverWorkerStub()
	}

	var sceneStub: (_ scene: Act1Scene) -> UIViewController = { _ in XCTFail(); return UIViewController() }
	func scene(_ scene: Act1Scene) -> UIViewController {
		return sceneStub(scene)
	}

	var createAct2DependenciesStub: (_ user: User) -> Act2DependenciesInterface = { _ in XCTFail(); return Act2DependenciesMock() }
	func createAct2Dependencies(user: User) -> Act2DependenciesInterface {
		return createAct2DependenciesStub(user)
	}
}
