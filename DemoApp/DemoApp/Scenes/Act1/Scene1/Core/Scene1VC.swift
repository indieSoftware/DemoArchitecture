import Shared
import UIKit

/**
 The view controller which is the main module for this scene and thus creates and holds all components of it.
 */
final class Scene1VC: BaseViewController {
	/// A strong reference to the interactor which binds the display to the logic.
	private var interactor: Scene1Interactor?

	// A strong reference to the presenter which presents data on the view.
	private let presenter = Scene1Presenter()

	// A strong reference to the navigator which is responsible for routing.
	private let navigator: Scene1Navigator

	// A strong reference to the business logic.
	private let logic: Scene1Logic

	/// The table controller for this scene.
	private var tableController: Scene1TableController?

	required init(setupModel: SetupModel.Scene1, dependencies actDependencies: Act1DCInterface) {
		navigator = Scene1Navigator(dependencies: actDependencies)
		let logicDependencies = Scene1Model.LogicDependencies(
			setupModel: setupModel,
			presenter: presenter,
			navigator: navigator,
			actDependencies: actDependencies
		)
		logic = Scene1Logic(dependencies: logicDependencies)
		super.init()
		navigator.viewController = self
		presenter.viewController = self
	}

	// MARK: - View

	override func loadView() {
		let sceneView = Scene1View()
		view = sceneView
		tableController = Scene1TableController(tableView: sceneView.tableView, logic: logic)
		presenter.tableController = tableController
		presenter.view = sceneView
		interactor = Scene1Interactor(view: sceneView, logic: logic)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Request initial display data.
		if isMovingToParent || isBeingPresented {
			logic.updateInitialDisplay()
		}
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		coordinator.animate(alongsideTransition: nil) { [weak self] _ in
			self?.logic.displayRotated()
		}
	}
}
