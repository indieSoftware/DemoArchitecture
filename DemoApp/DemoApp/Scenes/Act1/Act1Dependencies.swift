import ServerWorker
import Shared
import UIKit

class Act1Dependencies: Act1DependenciesInterface {
	lazy var factory: Act1FactoryInterface = {
		Act1Factory(dependencies: self)
	}()

	let settings: InternalSettingsInterface
	let serverWorker: ServerWorkerInterface

	init(
		settings: InternalSettingsInterface,
		serverWorker: ServerWorkerInterface
	) {
		self.settings = settings
		self.serverWorker = serverWorker
	}
}

class Act1Factory: Act1FactoryInterface {
	/// The reference to the dependency container, but unowned because the container owns the factory.
	unowned let dependencies: Act1DependenciesInterface

	init(dependencies: Act1DependenciesInterface) {
		self.dependencies = dependencies
	}

	func scene(_ scene: Act1Scene) -> UIViewController {
		switch scene {
		case let .scene1(setupModel):
			return Scene1VC(setupModel: setupModel, dependencies: dependencies)
		}
	}

	func act2Dependencies(user: User) -> Act2DependenciesInterface {
		return Act2Dependencies(act1Dependencies: dependencies, user: user)
	}
}
