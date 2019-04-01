/// The logic interface, which is available to the display for informing about user initiated processes.
protocol Scene1LogicInterface: AnyObject {
	/**
	 Requests a display update with the current state's data.
	 */
	func updateDisplay()

	/**
	 Updates the internal settings if not yet done.
	 */
	func updateSettings()

	/**
	 An entry with a title has been selected and Scene2 will be shown with it.

	 - parameter title: The selected entry's title.
	 */
	func entrySelected(title: String)

	/**
	 An entry's info has been selected and will be should in the headline.

	 - parameter title: The entry's title.
	 */
	func entryInfoSelected(title: String)
}
