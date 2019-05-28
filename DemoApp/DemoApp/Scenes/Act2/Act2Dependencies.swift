import ServerWorker
import Shared

/// All scenes in this act.
enum Act2Scene {
	case scene2(SetupModel.Scene2)
}

/// The interface for the act's dependency resolver.
protocol Act2DependenciesInterface {
	/// A server worker for querying server requests.
	var serverWorker: ServerWorkerInterface { get }
	/// The logged-in user as a demo dependency.
	var user: User { get }

	/**
	 Creates and returns a new scene.

	 - parameter scene: Which scene to create.
	 - returns: The created scene.
	 */
	func scene(_ scene: Act2Scene) -> UIViewController
}

/// The concrete act's dependency resolver.
class Act2Dependencies: Act2DependenciesInterface {
	let serverWorker: ServerWorkerInterface
	let user: User

	init(act1Dependencies: Act1DependenciesInterface, user: User) {
		serverWorker = act1Dependencies.serverWorker
		self.user = user
	}

	func scene(_ scene: Act2Scene) -> UIViewController {
		switch scene {
		case let .scene2(setupModel):
			return Scene2VC(setupModel: setupModel, dependencies: self)
		}
	}
}

/// A demo dependency simulating a logged-in user class.
class User {}
