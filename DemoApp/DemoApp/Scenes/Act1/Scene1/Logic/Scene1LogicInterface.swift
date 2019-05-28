import Shared

/// The logic interface, which is available to the display for informing about user initiated processes.
protocol Scene1LogicInterface: AnyObject {
	/**
	 Updates the display with initial data by performing an initial search with an empty query string.
	 */
	func updateInitialDisplay()

	/**
	 Informs that the display has been rotated so the rotation counter gets increased.
	 */
	func displayRotated()

	/**
	 Searches for a given text and updates the display accordingly.

	 - parameter text: The text to search for.
	 */
	func searchForText(_ text: String)

	/**
	 Dismisses the keyboard when it is shown.
	 */
	func dismissKeyboard()

	/**
	 Takes the suggestion's term, passes it to the display for showing in the search field and performs a new search with it.

	 - parameter suggestion: The suggestion to adopt.
	 */
	func adoptSuggestion(_ suggestion: Suggestion)

	/**
	 Routes to `Scene2` with the given suggestion passed to it.

	 - parameter suggestion: The suggestion to pass.
	 */
	func showSuggestionDetails(_ suggestion: Suggestion)
}
