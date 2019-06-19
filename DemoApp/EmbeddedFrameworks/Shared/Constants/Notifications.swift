import Foundation

extension Const {
	/// Notification constants and their user info keys.
	public enum Notification {
		/// Custom notification names to use for sending notifications through the app.
		public enum Name {
			/// Informs that the app's internal settings have been changed.
			/// Provides a `userInfo` dictionary as parameter.
			public static let InternalSettingsDidChange = Foundation.Notification.Name("MYInternalSettingsDidChangeNotification")
		}

		/// Keys for a notification `userInfo` dictionary. The key's name begins with the notification's name for which it is.
		public enum UserInfoKey {
			// MARK: - InternalSettingsDidChange

			/// Key for the type of internal setting which has been changed.
			/// Value is a `Const.InternalSetting.Key` element.
			public static let InternalSettingsDidChangeSettingKey = "InternalSettingsDidChangeSettingKey"
		}
	}
}
