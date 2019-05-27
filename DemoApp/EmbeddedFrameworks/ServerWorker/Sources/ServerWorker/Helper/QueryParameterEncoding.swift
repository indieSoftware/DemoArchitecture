import Foundation

/// Encodes any encodable to a `URLQueryItem` list which gets sorted ascending by their keys.
enum URLQueryItemEncoder {
	public static func encode<T: Encodable>(_ encodable: T) throws -> [URLQueryItem] {
		let parametersData = try JSONEncoder().encode(encodable)
		let httpParameters = try JSONDecoder().decode(HTTPParameterDictionary.self, from: parametersData)
		let sortedParameters = httpParameters.sorted { $0.key < $1.key }
		let cleanedParameters = sortedParameters.map { URLQueryItem(name: $0, value: $1.description) }
		return cleanedParameters
	}
}

/// A dictionary with strings as keys and `HTTPParameter` as values.
typealias HTTPParameterDictionary = [String: HTTPParameter]

/// Utility type to decode any type of HTTP parameter.
enum HTTPParameter: Decodable {
	case string(String)
	case bool(Bool)
	case int(Int)
	case double(Double)

	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()

		if let string = try? container.decode(String.self) {
			self = .string(string)
		} else if let bool = try? container.decode(Bool.self) {
			self = .bool(bool)
		} else if let int = try? container.decode(Int.self) {
			self = .int(int)
		} else if let double = try? container.decode(Double.self) {
			self = .double(double)
		} else {
			throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "HTTP parameter not decodable"))
		}
	}

	/// The parameter as a string representation.
	var description: String {
		switch self {
		case let .string(string):
			return string
		case let .bool(bool):
			return String(describing: bool)
		case let .int(int):
			return String(describing: int)
		case let .double(double):
			return String(describing: double)
		}
	}
}
