import Shared
import UIKit

/**
 The view controller which is the main module for this scene and thus creates and holds all components of it.
 */
final class Scene1VC: BaseViewController {
	/// The interactor which binds the display to the logic.
	private var interactor: Scene1Interactor?

	/// The table controller for this scene.
	private var tableController: Scene1TableController?

	/// The injected dependencies.
	private let dependencies: Scene1VCDependencyResolver

	// The model parameter to set up the logic.
	// weaver: setupModel <= Scene1Setup

	// A strong reference to the navigator.
	// weaver: navigator = Scene1Navigator
	// weaver: navigator.scope = .container

	// A strong reference to the presenter.
	// weaver: presenter = Scene1Presenter
	// weaver: presenter.scope = .container

	// A strong reference to the business logic.
	// weaver: logic = Scene1Logic
	// weaver: logic.scope = .container

	required init(injecting dependencies: Scene1VCDependencyResolver) {
		self.dependencies = dependencies
		super.init()
		dependencies.navigator.viewController = self
		dependencies.presenter.viewController = self
	}

	// MARK: - View

	override func loadView() {
		let sceneView = Scene1View()
		view = sceneView
		let logic = dependencies.logic(setupModel: dependencies.setupModel) // TODO: remove
		tableController = Scene1TableController(tableView: sceneView.tableView, logic: logic)
		dependencies.presenter.tableController = tableController
		dependencies.presenter.view = sceneView
		interactor = Scene1Interactor(view: sceneView, logic: logic)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Request initial display data.
		let logic = dependencies.logic(setupModel: dependencies.setupModel) // TODO: remove
		logic.updateDisplay()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		let logic = dependencies.logic(setupModel: dependencies.setupModel) // TODO: remove
		logic.updateSettings()
	}
}
