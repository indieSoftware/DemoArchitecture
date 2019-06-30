@testable import DemoAppDev
import Shared
import XCTest

class InternalSettingsMock: InternalSettingsInterface {
	var updateSettingsStub: (_ testFlags: TestFlags?) -> Bool = { _ in XCTFail(); return false }
	func updateSettings(testFlags: TestFlags?) -> Bool {
		return updateSettingsStub(testFlags)
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
