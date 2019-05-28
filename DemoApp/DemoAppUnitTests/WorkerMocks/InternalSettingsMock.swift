@testable import DemoAppDev
import Shared
import XCTest

class InternalSettingsMock: InternalSettingsInterface {
	var updateSettingsStub: (_ testScenario: Const.AppArgument.TestScenario?) -> Bool = { _ in XCTFail(); return false }
	func updateSettings(testScenario: Const.AppArgument.TestScenario?) -> Bool {
		return updateSettingsStub(testScenario)
	}

	var settingsVersionGetStub: () -> Int = { XCTFail(); return 0 }
	var settingsVersionSetStub: (Int) -> Void = { _ in XCTFail() }
	var settingsVersion: Int {
		get {
			return settingsVersionGetStub()
		}
		set {
			settingsVersionSetStub(newValue)
		}
	}
}
