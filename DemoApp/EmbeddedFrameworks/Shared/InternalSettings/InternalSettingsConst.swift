extension Const {
	/// Constants for the internal settings.
	public struct InternalSettings {
		/// The latest version number to which the internal settings should be updated.
		/// Assign new value when a new settings version is introduced.
		public static let LatestVersionNumber = SettingsVersion1

		/// The internal settings version number for app v1.0.
		public static let SettingsVersion1 = 1

		// MARK: - Setting keys

		/// Any setting keys used for saving and retrieving values to and from the user defaults.
		public struct Key: Hashable, Equatable, RawRepresentable, ExpressibleByStringLiteral {
			/// The setting's version key for versioning the settings (value is an integer).
			public static let SettingsVersion: Key = "SettingsUserDefaultsKeySettingsVersion"

			// MARK: - Key implementation

			/// The raw string value of the key.
			public var rawValue: String

			// MARK: - RawRepresentable & ExpressibleByStringLiteral

			public init(rawValue: String) {
				self.rawValue = rawValue
			}

			public init(stringLiteral value: String) {
				rawValue = value
			}

			// MARK: Equality & Hashable

			public static func == (lhs: Const.InternalSettings.Key, rhs: Const.InternalSettings.Key) -> Bool {
				return lhs.rawValue == rhs.rawValue
			}

			public static func == (lhs: String, rhs: Const.InternalSettings.Key) -> Bool {
				return lhs == rhs.rawValue
			}

			public static func == (lhs: Const.InternalSettings.Key, rhs: String) -> Bool {
				return lhs.rawValue == rhs
			}

			public static func ~= (pattern: String, value: Const.InternalSettings.Key) -> Bool {
				return pattern == value
			}

			public static func ~= (pattern: Const.InternalSettings.Key, value: String) -> Bool {
				return pattern == value
			}
		}
	}
}
