import Foundation
import Shared

/**
 Requests and provides resources from and to the server. Use this to call some remote APIs.

 Inspired by:
 https://medium.com/makingtuenti/writing-a-scalable-api-client-in-swift-4-b3c6f7f3f3fb
 https://medium.com/@frederikjacques/repository-design-pattern-in-swift-952061485aa
 */
public final class ServerWorker {
	/// The server's base URL where all requests are performed to.
	private let baseEndpointUrl: URL

	// TODO: Consider using Alamofire instead of URLSession.
	/// Foundation's `URLSession` is used as the underlying session resolver for sending requests.
	private let session = URLSession(configuration: .default)

	/**
	 Default initializer.

	 - parameter baseUrl: The URL to the server for applying any requests.
	 */
	public init(baseUrl: String) {
		guard let url = URL(string: baseUrl) else {
			fatalError("Malformed URL string: \(baseUrl)")
		}
		baseEndpointUrl = url
	}

	/**
	 Creates the corresponding URL to call for a given request.
	 The parameters will be composed in a sorted order so the URL is deterministic.

	 - parameter request: The request for which to create the URL.
	 - returns: The URL for the request.
	 */
	func endpoint<T: ServerRequest>(for request: T) -> URL {
		let baseUrl = baseEndpointUrl.appendingPathComponent(request.resourceName)
		guard var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
			fatalError("URL components not resolvable against base URL: \(baseUrl)")
		}

		// Custom query items needed for the specific request.
		do {
			components.queryItems = try URLQueryItemEncoder.encode(request)
		} catch {
			fatalError("Parameters not codable: \(error)")
		}

		// Construct the final URL with all the previous data.
		guard let url = components.url else {
			fatalError("URL couldn't be created for components: \(components)")
		}
		return url
	}
}

// MARK: - ServerWorkerInterface

extension ServerWorker: ServerWorkerInterface {
	public func send<T: ServerRequest>(_ request: T, completion: @escaping ServerResultCallback<T.Response>) {
		let endpointUrl = endpoint(for: request)
		var urlRequest = URLRequest(url: endpointUrl)
		urlRequest.httpMethod = request.httpMethod.rawValue

		// Send request.
		let task = session.dataTask(with: urlRequest) { data, response, error in
			guard let data = data,
				let httpResponse = response as? HTTPURLResponse,
				httpResponse.statusCode == 200 else {
				// An error occurred.
				Log.warn("Request error\nError:\(String(describing: error))\nRequest:\(urlRequest.description)\nResponse:\(String(describing: response))")
				DispatchQueue.main.async {
					completion(.failure(.server))
				}
				return
			}

			// Received some data, try to convert it from Latin1 to UTF8.
			guard let decodedJsonString = String(data: data, encoding: .isoLatin1),
				let jsonData = decodedJsonString.data(using: .utf8) else {
				let dataString = String(decoding: data, as: UTF8.self)
				Log.warn("Result not Latin1 decodable\nRequest:\(urlRequest.description)\nResponse:\(dataString)")
				DispatchQueue.main.async {
					completion(.failure(.decoding))
				}
				return
			}

			// Decode the data into the response type.
			do {
				let decodedData = try JSONDecoder().decode(T.Response.self, from: jsonData)
				DispatchQueue.main.async {
					completion(.success(decodedData))
				}
			} catch {
				// Decoding failed.
				let dataString = String(decoding: data, as: UTF8.self)
				Log.warn("Result not decodable\nRequest:\(urlRequest.description)\nResponse:\(dataString)")
				DispatchQueue.main.async {
					completion(.failure(.decoding))
				}
			}
		}
		task.resume()
	}
}
