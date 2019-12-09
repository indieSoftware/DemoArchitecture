import Foundation

extension Const {
	/// Notification constants and their user info keys.
	public enum Notification {
		// MARK: - Notification Names

		/// Custom notification names to use for sending notifications through the app.
		public enum Name {
			/// Informs that the app's internal settings have been changed.
			/// Provides a `userInfo` dictionary as parameter.
			public static let InternalSettingsDidChange = Foundation.Notification.Name("MYInternalSettingsDidChangeNotification")
		}

		// MARK: - UserInfo Keys

		/// Keys for a notification `userInfo` dictionary. The key's name begins with the notification's name for which it is.
		public enum UserInfoKey {
			/// Key for the type of internal setting which has been changed.
			/// `userInfo` key for `InternalSettingsDidChange` notifications.
			/// Value is a `Const.InternalSetting.Key` element.
			public static let InternalSettingsDidChangeSettingKey = "InternalSettingsDidChangeSettingKey"
		}
	}
}
