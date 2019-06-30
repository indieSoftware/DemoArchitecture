/// The model representing the content of a `Config.plist` file in the `Resources` folder.
public struct Configuration: Decodable {
	/// The config's name logged during app start to see which config is used.
	public let config: String

	/// The URL to the backend as endpoint for any server requests.
	public let backendUrl: String

	/// Any special flags for testing the app.
	public let testFlags: TestFlags?
}

/// Any special behavior to apply when testing the app.
public struct TestFlags: Decodable {
	/// If true resets all persisted data, e.g. the internal settings, to its default values.
	public let resetData: Bool

	/// If true makes the app start faster without the splash animation.
	public let noSplash: Bool

	/// If true then special test data is set on app start.
	public let applyTestData: Bool
}
