/// Errors which could arise when working with the `ServerWorker`.
public enum ServerWorkerError: Error {
	/// The returned data couldn't be decoded.
	case decoding
	/// The server returned an error or the connection couldn't be established.
	case server
}

/// The type of completion handler for requests.
/// The closure's parameter is the `Result` type which encapsulates either a success with the correct data or an error.
public typealias ServerResultCallback<Value> = (Result<Value, ServerWorkerError>) -> Void

/// The HTTP method types supported.
public enum HTTPMethod: String {
	/// Request a prepresentation of a specific resource, retrieve data.
	case GET
	/// Submit an entity to a specific resource, causing side effects or a server state change.
	case POST
	/// Replace the current representation of a target resource.
	case PUT
	/// Delete a specific resource.
	case DELETE
}
