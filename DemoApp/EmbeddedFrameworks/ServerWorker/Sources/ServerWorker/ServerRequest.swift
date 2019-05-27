import Foundation

/// The base protocol for all requests.
/// The request must also conform to `Encodable`.
/// That way all stored public parameters will be encoded as parameters.
/// For this to work the parameters must have a `HTTPParameter` representation.
public protocol ServerRequest: Encodable {
	/// The response type for this request.
	associatedtype Response: Decodable

	/// The endpoint for this request which is the last part of the URL without the base path.
	/// Has to be a computed property to prevent it from automatically get encoded and added as URL parameter
	/// or exclude it by having it not mentioned in a `CodingKeys` enum.
	var resourceName: String { get }

	/// The method of the request which type to use, e.g. `GET`, `POST`.
	/// Has to be a computed property to prevent it from automatically get encoded and added as URL parameter
	/// or exclude it by having it not mentioned in a `CodingKeys` enum.
	var httpMethod: HTTPMethod { get }
}

/// A global namespace for all server requests.
public enum Request {
	// All concrete server requests should be defined in their own extensions.
}
