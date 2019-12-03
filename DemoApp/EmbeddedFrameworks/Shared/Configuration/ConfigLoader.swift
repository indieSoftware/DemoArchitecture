import Foundation

/**
 A helper to load a configuration plist file and mapping it to its model.
 The config file should contain all necessary data to run the app, e.g. server URLs, token IDs, etc.
 The config has to match the corresponding model in `ConfigModel.swift`.
 */
public final class ConfigLoader {
	/// The name of the config plist file in the bundle.
	public static let ConfigName = "Config.plist"

	/**
	 Loads the configuration from the config file by parsing it into the model.

	 - parameter fileName: The config's file name to load the config from.
	 - returns: The configuration data model filled with the values from the file.
	 */
	public static func parseFile(named fileName: String = ConfigName) -> Configuration {
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
}
