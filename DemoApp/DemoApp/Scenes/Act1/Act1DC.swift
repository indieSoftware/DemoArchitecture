import ServerWorker
import Shared
import UIKit

class Act1DC: Act1DCInterface {
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
	unowned let dependencies: Act1DCInterface

	init(dependencies: Act1DCInterface) {
		self.dependencies = dependencies
	}

	func scene(_ scene: Act1Scene) -> UIViewController {
		switch scene {
		case let .scene0(setupModel):
			return Scene0VC(setupModel: setupModel, dependencies: dependencies)
		case let .scene1(setupModel):
			return Scene1VC(setupModel: setupModel, dependencies: dependencies)
		}
	}

	func act2DC(user: User) -> Act2DCInterface {
		return Act2DC(act1DC: dependencies, user: user)
	}
}
