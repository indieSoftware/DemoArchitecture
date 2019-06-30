public final class ConfigLoader {
	/**
	 Loads the configuration from the `Config.plist` file.

	 - parameter configName: The file name to load the config from.
	 - returns: The configuration data model.
	 */
	public static func getConfig(forEnvironment configName: ConfigName = .default) -> Configuration {
		let fileName = configName.rawValue
		let fileEnding = "plist"

		// Load config file from bundle.
		guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileEnding),
			let fileData = FileManager.default.contents(atPath: filePath)
		else {
			fatalError("Config file '\(fileName).\(fileEnding)' not loadable!")
		}

		// Decode config file into struct.
		do {
			let config = try PropertyListDecoder().decode(Configuration.self, from: fileData)
			return config
		} catch {
			fatalError("Configuration not decodable from Config-file: \(error)")
		}
	}
}

/// The specific configuration file name. The string represents the file name without the `plist` extension.
public enum ConfigName: String {
	/// The default configuration file name which is used for normal debug or release builds, e.g. `Config.plist`.
	case `default` = "Config"
	/// The staging configuration file.
	case staging = "Config-staging"
}
