import UIKit

/// Navigation for this scene.
protocol Scene2NavigatorInterface: AnyObject {
	/**
	 Pops back to the previous scene.
	 */
	func scene1()

	/**
	 Creates and returns a sub-controller for embedding.

	 - returns: The desired view controller.
	 */
	func subController() -> UIViewController
}
