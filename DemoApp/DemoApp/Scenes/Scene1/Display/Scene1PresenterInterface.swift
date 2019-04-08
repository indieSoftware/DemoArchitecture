import Foundation
import ServerWorker
import Shared

/// The interface for presenting something in the view.
protocol Scene1PresenterInterface: AnyObject {
	/**
	 Updates the suggestion table list view with the given data.

	 - parameter suggestions: The suggestions to display.
	 */
	func suggestionList(suggestions: Suggestions)

	/**
	 Presents a server error via alert message to the user.

	 - parameter error: The server error to present.
	 */
	func serverError(_ error: ServerWorkerError)

	/**
	 Updates the search input text field with a provided text.

	 - parameter text: The text to apply to the text field.
	 */
	func searchText(_ text: String)
}
