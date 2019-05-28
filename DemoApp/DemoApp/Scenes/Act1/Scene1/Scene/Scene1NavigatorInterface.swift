/// Navigation for this scene.
protocol Scene1NavigatorInterface: AnyObject {
	/**
	 Pushes the scene on the nav controller.

	 - parameter setupModel: The model for setting up the new scene.
	 - parameter user: A dummy user object simulating a logged-in user for transitioning to the next act.
	 */
	func scene2(setupModel: SetupModel.Scene2, user: User)
}
