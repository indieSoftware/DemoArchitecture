public final class ConfigLoader {
	/**
	 Loads the configuration from the `Config.plist` file.

	 - parameter configName: The file name to load the config from.
	 - returns: The configuration data model.
	 */
	public static func getConfig(named configName: ConfigName = .default) -> Configuration {
		let fileName = configName.rawValue

		// Load config file from bundle.
		guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil),
			let fileData = FileManager.default.contents(atPath: filePath)
		else {
			fatalError("Config file '\(fileName)' not loadable!")
		}

		// Decode config file into struct.
		do {
			let config = try PropertyListDecoder().decode(Configuration.self, from: fileData)
			return config
		} catch {
			fatalError("Configuration not decodable from '\(fileName)': \(error)")
		}
	}

	/**
	 Retrieves the config name depending on the command line argumenst provided by app start.

	 - parameter commandLineArguments: The command line arguments passed to the app.
	 - returns: The config name for loading a configuration.
	    If no matching argument could be found, then `default` will be returned.
	 */
	public static func getConfigName(forCommandLineArguments commandLineArguments: [String]) -> ConfigName {
		if commandLineArguments.contains("staging") {
			return .staging
		} else {
			return .default
		}
	}
}

/// The specific configuration file name. The string represents the file name.
public enum ConfigName: String {
	/// The default configuration file name which is used for normal debug or release builds, e.g. `Config.plist`.
	case `default` = "Config.plist"
	/// The staging configuration file. Provide `staging` as command line argument to use this config.
	case staging = "Config-staging.plist"
}
