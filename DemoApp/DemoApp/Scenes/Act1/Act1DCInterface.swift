import ServerWorker
import Shared
import UIKit

/// The act's dependency container.
protocol Act1DCInterface: AnyObject {
	/// The configuration properties.
	var configuration: Configuration { get }

	/// The factory for creating new dependencies.
	var factory: Act1FactoryInterface { get }

	/// The internal settings to persist app settings data.
	var settings: InternalSettingsInterface { get }

	/// A server worker for querying server requests.
	var serverWorker: ServerWorkerInterface { get }
}

/// The act's factory which creates new dependency objects.
protocol Act1FactoryInterface {
	/**
	 Creates and returns a new scene.

	 - parameter scene: Which scene to create.
	 - returns: The created scene.
	 */
	func scene(_ scene: Act1Scene) -> UIViewController

	/**
	 Creates a new dependency resolver for a different act.

	 - parameter user: The logged-in user.
	 - returns: The new dependency resolver.
	 */
	func act2DC(user: User) -> Act2DCInterface
}
