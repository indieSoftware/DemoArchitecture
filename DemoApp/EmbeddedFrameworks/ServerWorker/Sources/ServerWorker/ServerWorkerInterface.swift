/// The interface for accessing the server API.
public protocol ServerWorkerInterface {
	/**
	  Performs a server request.

	 The endpoint URL will be created from the provided request object.
	 When the server returns no data or a status code not equal to 200 then a failure with `ServerWorkerError.server` is returned.
	 When data is returned, but can't be decoded into the type defined by the request's `Response` type a failure with `ServerWorkerError.decoding` is returned.
	 If no error occured then a success with the decoded data is returned.

	  - parameter request: The request to perform.
	  - parameter completion: The callback informing about the request's result. Will be called on the main thread.
	 */
	func send<T: ServerRequest>(_ request: T, completion: @escaping ServerResultCallback<T.Response>)
}
