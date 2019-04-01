/**
 The app's internal settings which persists its properties and any app specific user changes between app starts.

 Everytime when a setting value has been altered a `InternalSettingsDidChange` notification will be send with a `userInfo` dict
 containing the changed setting's key as value for the user info's key `InternalSettingsDidChangeSettingType`.
 */
public protocol InternalSettingsInterface {
	/**
	 Updates the internal settings with default values for not yet initialized properties
	 or according to a given test scenario if provided.

	 This method has to be called after an app start so when the user starts the app the first time all setting properties get initialized properly.
	 Because when an app gets updated the app firstly gets terminated so the app delegate's `didFinishLaunchingWithOptions` method gets called
	 that would be the perfect place for calling this method.

	 If a test scenario is provided and the app is running in debug mode	the internal settings are cleared and the test scenario applied.
	 Otherwise the app and the properties are prepared for the normal app usage.
	 When new properties are introduced with an app update or something has changed, like new values for a property are added
	 then this method takes care of this.

	 The lastest version number can be seen via `Const.InternalSettings.LatestVersionNumber`.

	 - parameter testScenario: The test scenario to use when the app is in test mode.
	 - returns: `true` if an update has been performed, `false` when the settings were already up to date or the app is in test mode.
	 */
	@discardableResult
	func updateSettings(testScenario: Const.AppArgument.TestScenario?) -> Bool

	/// The current setting's version.
	/// Returns 0 when none has been set.
	var settingsVersion: Int { get set }
}
