import ServerWorker
import UIKit

class Act2Dependencies: Act2DependenciesInterface {
	lazy var factory: Act2FactoryInterface = {
		Act2Factory(dependencies: self)
	}()

	let serverWorker: ServerWorkerInterface
	let user: User

	init(act1Dependencies: Act1DependenciesInterface, user: User) {
		serverWorker = act1Dependencies.serverWorker
		self.user = user
	}
}

class Act2Factory: Act2FactoryInterface {
	/// The reference to the dependency container, but unowned because the container owns the factory.
	unowned let dependencies: Act2Dependencies

	init(dependencies: Act2Dependencies) {
		self.dependencies = dependencies
	}

	func scene(_ scene: Act2Scene) -> UIViewController {
		switch scene {
		case let .scene2(setupModel):
			return Scene2VC(setupModel: setupModel, dependencies: dependencies)
		}
	}
}
