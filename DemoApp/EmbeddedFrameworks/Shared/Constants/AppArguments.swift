extension Const {
	/// Arguments passed on app start when targeting tests or a debug version.
	/// To apply the arguments "Edit Scheme", go to "Run" phase and select the "Arguments" tab.
	/// Add the arguments to "Arguments Passed On Launch" and make sure their checkmark is ticked.
	public struct AppArgument {
		/// A string appended to the app start arguments to indicate that the app is under UI test and thus any persisted states have to be cleared.
		public static let testMode = "--testMode"

		/// Defines a specific test scenario for testing.
		/// Needs to be added in conjunction with `testMode`.
		/// Only one test scenario is used, which one when multiple are provided is undefined.
		public enum TestScenario: String {
			/// No specific scenario to apply, but still in test mode.
			case none = ""
			/// User has used the app so some data is already provided by the user.
			case appUsed = "--appUsed"

			/**
			 Retrieves the test scenario provided by the command line arguments if the `testMode` flag is set and a debug build is used.
			 If multiple scenarios are provided one at random is taken.

			 - parameter commandLineArguments: The command line arguments passed to the app which might include a scenario.
			 */
			public init?(commandLineArguments: [String]?) {
				#if DEBUG
					guard let commandLineArguments = commandLineArguments, commandLineArguments.contains(Const.AppArgument.testMode) else {
						return nil
					}

					if commandLineArguments.contains(TestScenario.appUsed.rawValue) {
						self = .appUsed
					} else {
						self = .none
					}
				#else
					return nil
				#endif
			}
		}
	}
}
