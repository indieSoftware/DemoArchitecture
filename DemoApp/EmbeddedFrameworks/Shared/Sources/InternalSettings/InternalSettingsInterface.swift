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

	 When new properties are introduced with an app update or something has changed, like new values for a property are added
	 then this method takes care of this.

	 The lastest version number can be seen via `Const.InternalSettings.LatestVersionNumber`.

	 Special behavior can be applied for testing some scenarios by providing test flags.

	 - parameter testFlags: Some flags to apply when testing special behaviors. Set to `nil` for not applying any special testing cases.
	 - returns: `true` if an update has been performed, `false` when the settings were already up to date or any test flags were provided.
	 */
	@discardableResult
	func updateSettings(testFlags: TestFlags?) -> Bool

	/// The current setting's version.
	/// Returns 0 when none has been set.
	var settingsVersion: Int { get set }
}
