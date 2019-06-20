/// Navigation for this scene.
protocol Scene0NavigatorInterface: AnyObject {
	/**
	 Creates a new navController with the destination scene and presents it.

	 - parameter setupModel: The model for setting up the new scene.
	 */
	func scene1(setupModel: SetupModel.Scene1)
}
