/// Navigation for this scene.
protocol Scene1NavigatorInterface: AnyObject {
	/**
	 Pushes the scene on the nav controller.

	 - parameter setupModel: The model for setting up the new scene.
	 */
	func scene2(setupModel: Scene2Setup)
}
