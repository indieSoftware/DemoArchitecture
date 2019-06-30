@testable import DemoAppDev
import ServerWorker
import Shared
import XCTest

class Act1DCStub: Act1DCInterface {
	var factory: Act1FactoryInterface = Act1FactoryMock()
	var testScenario: TestScenario = .none
	var configuration: Configuration = ConfigLoader.getConfig(forEnvironment: .default)
	var settings: InternalSettingsInterface = InternalSettingsMock()
	var serverWorker: ServerWorkerInterface = ServerWorkerMock()
}

class Act1FactoryMock: Act1FactoryInterface {
	var sceneStub: (_ scene: Act1Scene) -> UIViewController = { _ in XCTFail(); return UIViewController() }
	func scene(_ scene: Act1Scene) -> UIViewController {
		return sceneStub(scene)
	}

	var act2DCStub: (_ user: User) -> Act2DCInterface = { _ in XCTFail(); return Act2DCStub() }
	func act2DC(user: User) -> Act2DCInterface {
		return act2DCStub(user)
	}
}
