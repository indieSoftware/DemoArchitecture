import ServerWorker
import UIKit

/// The act's dependency container.
protocol Act2DCInterface: AnyObject {
	/// The factory for creating new dependencies.
	var factory: Act2FactoryInterface { get }

	/// A server worker for querying server requests.
	var serverWorker: ServerWorkerInterface { get }

	/// The logged-in user as a demo dependency.
	var user: User { get }
}

/// The act's factory which creates new dependency objects.
protocol Act2FactoryInterface {
	/**
	 Creates and returns a new scene.

	 - parameter scene: Which scene to create.
	 - returns: The created scene.
	 */
	func scene(_ scene: Act2Scene) -> UIViewController
}

/// A demo dependency simulating a logged-in user class.
class User {}
