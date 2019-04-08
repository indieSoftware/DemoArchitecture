import UIKit

extension Const {
	public enum App {
		/// The app's group identifier.
		public static let groupIdentifier = "group.de.indie-software.demoapp"
	}

	public enum Time {
		/// The default duration for debouncing UI actions.
		public static let defaultDebounceDuration = DispatchTimeInterval.milliseconds(300)
	}
}
