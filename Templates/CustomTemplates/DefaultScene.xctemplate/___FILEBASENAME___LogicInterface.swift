/// The logic interface, which is available to the display for informing about user initiated processes.
protocol ___VARIABLE_sceneName___LogicInterface: AnyObject {
	/**
	 Requests a display update with the current state's data.
	 */
	func updateDisplay()

    /**
     Updates the parent scene with the data to return back.
     */
    func updateParentScene()
}
