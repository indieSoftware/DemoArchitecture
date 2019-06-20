/**
 Defines a specific app scenario, e.g. to set up a concrete state for testing.

 Only one test scenario is used, which one when multiple are provided is undefined.
 When no paramter is provided then the scenario `none` is used, which indicates no test scenario.

 Arguments passed on app start should be transformed into specific scenarios via the initializer.
 This is useful when targeting tests or a debug version.
 To apply the arguments in Xcode go to "Edit Scheme" -> "Run" phase and select the "Arguments" tab.
 Add the arguments to "Arguments Passed On Launch" and make sure their checkmark is ticked.
 */
public enum TestScenario: String {
	/// No test scenario to apply.
	/// This is the only state which indicates a non-test mode.
	/// Should be the only scenario used in a release build.
	case none = "none"

	/// A test scenario which only makes the app start faster without the splash animation
	/// and resets the internal settings.
	case fastStart = "fastStart"

	/**
	 Retrieves the test scenario provided by the provided command line arguments.
	 Use this only in a debug build, never in a release version!

	 If multiple scenarios are provided one at random is taken.
	 If no flag is set then the mode `none` is used.

	 - parameter commandLineArguments: The command line arguments passed to the app which might include a scenario.
	 */
	public init(commandLineArguments: [String]) {
		#if DEBUG
			if commandLineArguments.contains(TestScenario.none.rawValue) {
				self = .none
			} else if commandLineArguments.contains(TestScenario.fastStart.rawValue) {
				self = .fastStart
			} else {
				self = .none
			}
		#else
			fatalError("Never use scenarios in a release build!")
		#endif
	}
}
