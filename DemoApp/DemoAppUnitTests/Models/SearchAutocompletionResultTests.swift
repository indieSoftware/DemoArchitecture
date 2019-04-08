@testable import Shared
import XCTest

class SearchAutocompletionResultTests: XCTestCase {
	/// A server result string can be decoded into a model.
	func testModelDecodable() {
		let jsonString = #"["Lorem",["lorem ipsum","lorem ipsum generator","lorem ipsum deutsch"]]"#
		guard let jsonData = jsonString.data(using: .utf8) else { XCTFail(); return }
		let expectedModel = SearchAutocompletionResult(query: "Lorem", suggestions: ["lorem ipsum", "lorem ipsum generator", "lorem ipsum deutsch"])

		do {
			let model = try JSONDecoder().decode(SearchAutocompletionResult.self, from: jsonData)

			XCTAssertEqual(expectedModel, model)
		} catch {
			XCTFail("Exception thrown: \(error)")
		}
	}

	/// Decoding an invalid json string into a model throws an exception.
	func testModelInvalidDecodeThrows() {
		let jsonString = #"["Query"]"#
		guard let jsonData = jsonString.data(using: .utf8) else { XCTFail(); return }
		XCTAssertThrowsError(try JSONDecoder().decode(SearchAutocompletionResult.self, from: jsonData))
	}

	/// The model can be encoded into a JSON string.
	func testModelEncodable() {
		let model = SearchAutocompletionResult(query: "Lorem", suggestions: ["lorem ipsum", "lorem ipsum generator", "lorem ipsum deutsch"])
		let expectedJsonString = #"["Lorem",["lorem ipsum","lorem ipsum generator","lorem ipsum deutsch"]]"#

		do {
			let jsonData = try JSONEncoder().encode(model)
			let jsonString = String(data: jsonData, encoding: .utf8)

			XCTAssertEqual(expectedJsonString, jsonString)
		} catch {
			XCTFail("Exception thrown: \(error)")
		}
	}

	/// The models differ when their query string differ.
	func testModelQueryMissmatch() {
		let suggestions = Suggestions([])
		let model1 = SearchAutocompletionResult(query: "Query1", suggestions: suggestions)
		let model2 = SearchAutocompletionResult(query: "Query2", suggestions: suggestions)
		XCTAssertNotEqual(model1, model2)
	}

	/// The models differ when their suggestions differ.
	func testModelSuggestionsMissmatch() {
		let query = "Query"
		let model1 = SearchAutocompletionResult(query: query, suggestions: Suggestions([Suggestion("Sug1")]))
		let model2 = SearchAutocompletionResult(query: query, suggestions: Suggestions([Suggestion("Sug2")]))
		XCTAssertNotEqual(model1, model2)
	}
}
