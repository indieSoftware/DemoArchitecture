import ServerWorker
import Shared

/// All scenes in this act.
enum Act1Scene {
	case scene1(SetupModel.Scene1)
}

/// The interface for the act's dependency resolver.
protocol Act1DependenciesInterface {
	/// The internal settings to persist app settings data.
	var settings: InternalSettingsInterface { get }
	/// A server worker for querying server requests.
	var serverWorker: ServerWorkerInterface { get }

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
	func createAct2Dependencies(user: User) -> Act2DependenciesInterface
}

/// The concrete act's dependency resolver.
class Act1Dependencies: Act1DependenciesInterface {
	let settings: InternalSettingsInterface
	let serverWorker: ServerWorkerInterface

	init(settings: InternalSettingsInterface = InternalSettings(),
	     serverWorker: ServerWorkerInterface = ServerWorker()) {
		self.settings = settings
		self.serverWorker = serverWorker
	}

	func scene(_ scene: Act1Scene) -> UIViewController {
		switch scene {
		case let .scene1(setupModel):
			return Scene1VC(setupModel: setupModel, dependencies: self)
		}
	}

	func createAct2Dependencies(user: User) -> Act2DependenciesInterface {
		return Act2Dependencies(act1Dependencies: self, user: user)
	}
}
