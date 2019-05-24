import UIKit

extension Const {
	/// Any time values, durations, etc.
	public enum Time {
		/// The default duration for debouncing UI actions.
		public static let defaultDebounceDuration = DispatchTimeInterval.milliseconds(300)
	}
}
