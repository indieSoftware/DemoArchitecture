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
	// weaver: navigator = Scene1Navigator <- Scene1NavigatorInterface
	// weaver: navigator.scope = .container
	private var navigator: Scene1Navigator {
		guard let dependency = dependencies.navigator as? Scene1Navigator else { fatalError() }
		return dependency
	}

	// A strong reference to the presenter.
	// weaver: presenter = Scene1Presenter <- Scene1PresenterInterface
	// weaver: presenter.scope = .container
	private var presenter: Scene1Presenter {
		guard let dependency = dependencies.presenter as? Scene1Presenter else { fatalError() }
		return dependency
	}

	// A strong reference to the business logic.
	// weaver: logic = Scene1Logic <- Scene1LogicInterface
	// weaver: logic.scope = .container
	private var logic: Scene1Logic {
		// TODO: Remove unused logic parameter as soon as weaver supports it
		guard let dependency = dependencies.logic(setupModel: dependencies.setupModel) as? Scene1Logic else { fatalError() }
		return dependency
	}

	required init(injecting dependencies: Scene1VCDependencyResolver) {
		self.dependencies = dependencies
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
