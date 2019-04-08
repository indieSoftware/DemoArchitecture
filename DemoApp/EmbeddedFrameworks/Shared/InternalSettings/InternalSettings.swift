import UIKit

public final class InternalSettings {
	// MARK: - Properties

	/// The user defaults to use by this settings.
	private let userDefaults: UserDefaults

	/// Returns the `UserDefaults` for a group identifier to persist the app's internal settings to.
	public static let getUserDefaults: () -> UserDefaults = {
		if let defaults = UserDefaults(suiteName: Const.App.groupIdentifier) {
			return defaults
		} else {
			fatalError("Should use the user defaults with the group identifier")
		}
	}

	// MARK: - Init

	/**
	 Initializes the settings.

	 - parameter userDefaults: The user default object to use for persisting the app settings.
	 */
	public init(userDefaults: UserDefaults = getUserDefaults()) {
		self.userDefaults = userDefaults
	}
}

// MARK: - InternalSettingsInterface

extension InternalSettings: InternalSettingsInterface {
	@discardableResult
	public func updateSettings(testScenario: Const.AppArgument.TestScenario? = nil) -> Bool {
		// If a test scenario is provided only apply it instead of the normal update process.
		if let testScenario = testScenario {
			#if DEBUG
				applyTestScenario(testScenario)
			#else
				fatalError("'testScenario' not supported in release version")
			#endif
			return false
		}

		// Not in test mode, try updating the settings.
		return applySettingsUpdate()
	}

	// MARK: - Setting properties

	public var settingsVersion: Int {
		get {
			return userDefaults.integer(forKey: Const.InternalSettings.Key.SettingsVersion.rawValue)
		}
		set {
			userDefaults.set(newValue, forKey: Const.InternalSettings.Key.SettingsVersion.rawValue)
			NotificationCenter.default.post(name: Const.Notification.Name.InternalSettingsDidChange, object: self, userInfo:
				[Const.Notification.UserInfoKey.InternalSettingsDidChangeSettingKey: Const.InternalSettings.Key.SettingsVersion])
		}
	}
}

// MARK: - Settings versions

extension InternalSettings {
	private func applySettingsUpdate() -> Bool {
		let currentSettingsVersion = settingsVersion
		guard currentSettingsVersion < Const.InternalSettings.LatestVersionNumber else {
			// Settings are up to date.
			return false
		}

		// Settings version needs to be updated.
		// `appUpdate` indicates that this isn't a fresh app install, but an app update
		// so some properties may have already been set.
		let appUpdate = currentSettingsVersion > 0
		Log.info("\(appUpdate ? "Updating" : "Initializing") internal settings")

		// Start updating for each version in case the user has skipped some updates.
		if currentSettingsVersion < Const.InternalSettings.SettingsVersion1 {
			applySettingsVersion1(appUpdate: appUpdate)
		}

		// Finish update.
		settingsVersion = Const.InternalSettings.LatestVersionNumber
		#if DEBUG
			// Force sync during development otherwise terminating the app in Xcode
			// may prevent the user defaults to persist just in time.
			userDefaults.synchronize()
		#endif
		Log.info("Internal settings updated")
		return true
	}

	private func applySettingsVersion1(appUpdate: Bool) {
		Log.info("Setting update to v1")
	}
}

// MARK: - Test scenarios

extension InternalSettings {
	/**
	 Deletes and sets up the internal settings for a test mode scenario.

	 - parameter testScenario: The test scenario to apply.
	 */
	private func applyTestScenario(_ testScenario: Const.AppArgument.TestScenario) {
		// Delete app's persisted data.
		let domain = Bundle.main.bundleIdentifier!
		userDefaults.removePersistentDomain(forName: domain)
		userDefaults.synchronize()

		// Initialize settings with default values.
		updateSettings()

		// Set up settings according to scenario.
		switch testScenario {
		case .none:
			// No specific scenario.
			break
		case .appUsed:
			scenarioAppUsed()
		}
	}

	private func scenarioAppUsed() {
		// Nothing to do currently...
	}
}
