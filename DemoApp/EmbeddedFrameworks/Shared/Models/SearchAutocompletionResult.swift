/// The result type of a `SearchAutocompletion.Query` request.
/// Should match something like `["Lorem",["lorem ipsum","lorem ipsum generator"]]` where the first "Lorem" is the query's string.
public struct SearchAutocompletionResult: Codable, Equatable {
	/// The first element of the array which is the request's query string.
	public var query: String
	/// The request's results representing the suggestions and maps to the second element
	/// in the array which is an array of strings.
	public var suggestions: Suggestions

	public init(query: String, suggestions: Suggestions) {
		self.query = query
		self.suggestions = suggestions
	}

	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		query = try container.decode(String.self)
		suggestions = try container.decode(Suggestions.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(query)
		try container.encode(suggestions)
	}
}
