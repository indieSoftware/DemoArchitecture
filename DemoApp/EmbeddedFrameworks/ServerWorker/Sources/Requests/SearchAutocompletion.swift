import Shared

extension Request {
	/// Autocompletion suggestions for a search.
	public enum SearchAutocompletion {
		/// Requests all suggestions for a given search query.
		/// Example query: https://suggestqueries.google.com/complete/search?hl=en&output=firefox&q=ExampleQuery
		public struct Query: ServerRequest {
			public typealias Response = SearchAutocompletionResult

			public let resourceName = "search"

			public let httpMethod = HTTPMethod.GET

			enum CodingKeys: String, CodingKey {
				case query = "q"
				case output = "output"
				case language = "hl"
			}

			/**
			 Initializes the request with a query term.
			 The query term must be not empty because the server doesn't support an empty query.

			 - parameter query: The unmasked query term for which to get autocomplete suggestions.
			 */
			public init(_ query: String) {
				precondition(!query.isEmpty, "Empty query for autocompletion suggestions is not supported!")
				self.query = query
			}

			// MARK: - Parameter

			/// The query term to request autocompletion suggestions for.
			let query: String

			/// The format of the expected result, set to `firefox` to retrieve json data back.
			let output = "firefox"

			/// The language flag, set to `en`.
			let language = "en"
		}
	}
}
