/// The logic interface, which is available to the display for informing about user initiated processes.
protocol Scene2LogicInterface: AnyObject {
	/**
	 Requests a display update with the current state's data.
	 */
	func updateDisplay()

	/**
	 The rotation lock setting has been changed.

	 - parameter lockState: The new rotation lock state.
	 */
	func rotationLockChanged(lockState: DisplayRotation)

	/**
	 Resets the counter to zero and dismisses the scene.
	 */
	func resetAndDismiss()

	/**
	 Updates the parent scene with the new state.
	 */
	func updateParentScene()
}
