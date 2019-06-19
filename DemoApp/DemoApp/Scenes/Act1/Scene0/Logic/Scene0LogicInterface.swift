/// The logic interface, which is available to the display for informing about user initiated processes.
protocol Scene0LogicInterface: AnyObject {
	/**
	 Informs that the app has been started and ready to perform any tasks.
	 This will let the logic update the internal settings if needed and transition to the
	 appropriate scene after the splash screen has been shown.
	 */
	func start()
}
