import UIKit

extension Const {
	/// Any time values, durations, etc.
	public enum Time {
		/// The default duration in seconds for debouncing UI actions.
		public static let defaultDebounceDuration = 0.3

		/// The duration in seconds to fade in the splash screen.
		public static let splashFadeDuration = 1.0

		/// The minimal duration in seconds the splash sceen should be shown after animating in.
		public static let splashMinShowDuration = 0.5
	}
}
