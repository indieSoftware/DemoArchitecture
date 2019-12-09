import UIKit

extension Const {
	/// Any time values, durations, etc.
	public enum Time {
		/// The default duration in seconds for debouncing UI actions.
		public static let defaultDebounceDuration = 0.3

		/// The duration in seconds for the splash screen animation.
		public static let splashFadeDuration = 1.0

		/// The minimum duration in seconds the splash screen should be visible.
		public static let splashMinShowDuration = 1.5
	}
}
