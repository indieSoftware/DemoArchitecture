import UIKit

public final class InternalSettings {
	/// The user defaults to use by this settings.
	fileprivate static var userDefaults: UserDefaults = {
		if let defaults = UserDefaults(suiteName: Const.App.groupIdentifier) {
			return defaults
		} else {
			fatalError("Should use the user defaults with the group identifier")
		}
	}()

	/**
	 Initializes the settings.
	 */
	public init() {}

	// MARK: - Properties

	@InternalSettingsWrapper(key: Const.InternalSettings.Key.SettingsVersion, defaultValue: 0)
	public var settingsVersion: Int
}

// MARK: - InternalSettingsInterface

extension InternalSettings: InternalSettingsInterface {
	@discardableResult
	public func updateSettings(testFlags: TestFlags?) -> Bool {
		if let testFlags = testFlags, testFlags.resetData {
			// Delete app's persisted data.
			Self.userDefaults.removePersistentDomain(forName: Const.App.groupIdentifier)
			Self.userDefaults.synchronize()
		}

		// Try updating the settings.
		let updated = applySettingsUpdate()

		// Apply any test flag scenarios.
		if let testFlags = testFlags {
			if testFlags.applyTestData {
				applyTestData()
			}
		}

		return updated
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

		// The next settings version update comes here...

		// Finish update.
		settingsVersion = Const.InternalSettings.LatestVersionNumber
		#if DEBUG
			// Force sync during development otherwise terminating the app in Xcode
			// may prevent the user defaults to persist.
			Self.userDefaults.synchronize()
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
	private func applyTestData() {
		// Assign test scenario specific settings values.
	}
}

// MARK: - PropertyWrapper

/**
 A `PropertyWrapper` for the properties of the `InternalSettings`.

 Saves the property's value to the `InternalSettings`'s `userDefaults` and sends an `InternalSettingsDidChange` notification via `NotificationCenter`.
 */
@propertyWrapper
public struct InternalSettingsWrapper<T> {
	/// The settings key used for saving the value to the `UserDefaults`.
	private let key: Const.InternalSettings.Key
	/// The default value returned when no value could be retrieved from the `UserDefaults`.
	private let defaultValue: T

	/**
	 Initializes the property with a `UserDefaults` key and a default value.

	  - parameter key: The key used for saving the value to the `UserDefaults`.
	  - parameter defaultValue: The value to return when no value can be retrieved from the `UserDefaults`.
	 */
	public init(key: Const.InternalSettings.Key, defaultValue: T) {
		self.key = key
		self.defaultValue = defaultValue
	}

	public var wrappedValue: T {
		get {
			return InternalSettings.userDefaults.object(forKey: key.rawValue) as? T ?? defaultValue
		}
		set {
			InternalSettings.userDefaults.set(newValue, forKey: key.rawValue)
			NotificationCenter.default.post(name: Const.Notification.Name.InternalSettingsDidChange, object: nil, userInfo:
				[Const.Notification.UserInfoKey.InternalSettingsDidChangeSettingKey: key])
		}
	}
}
