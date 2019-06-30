/// The model representing the content of a `Config-XXX.plist` file in the `Resources` folder.
public struct Configuration: Decodable {
	/// An example value for a target-configuration dependency.
	public let value: String

	/// The URL to the backend as endpoint for any server requests.
	public let backendUrl: String
}
