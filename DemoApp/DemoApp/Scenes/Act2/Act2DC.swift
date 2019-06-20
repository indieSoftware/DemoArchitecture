import ServerWorker
import Shared
import UIKit

class Act2DC: Act2DCInterface {
	lazy var factory: Act2FactoryInterface = {
		Act2Factory(dependencies: self)
	}()

	let testScenario: TestScenario
	let serverWorker: ServerWorkerInterface
	let user: User

	init(act1DC: Act1DCInterface, user: User) {
		testScenario = act1DC.testScenario
		serverWorker = act1DC.serverWorker
		self.user = user
	}
}

class Act2Factory: Act2FactoryInterface {
	/// The reference to the dependency container, but unowned because the container owns the factory.
	unowned let dependencies: Act2DC

	init(dependencies: Act2DC) {
		self.dependencies = dependencies
	}

	func scene(_ scene: Act2Scene) -> UIViewController {
		switch scene {
		case let .scene2(setupModel):
			return Scene2VC(setupModel: setupModel, dependencies: dependencies)
		}
	}
}
