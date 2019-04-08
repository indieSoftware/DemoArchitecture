/// The logic interface, which is available to the display for informing about user initiated processes.
protocol Scene2LogicInterface: AnyObject {
	/**
	 Requests a display update with the current state's data.
	 */
	func updateDisplay()

	/**
	 Informs that the display has been rotated so the rotation counter gets increased
	 and the display is informed to update accordingly.
	 */
	func displayRotated()

	/**
	 The rotation lock state has been changed.

	 - parameter lockState: The new rotation lock state.
	 */
	func rotationLockChanged(lockState: DisplayRotation)

	/**
	 Resets the rotation counter to zero and dismisses the scene.
	 Informs the parent scene about the new rotation counter state.
	 */
	func resetAndDismiss()

	/**
	 Updates the parent scene with the new rotation counter state.
	 */
	func updateParentScene()
}
