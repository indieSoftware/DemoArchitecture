import Shared
import UIKit

/**
 The view controller which is the main module for this scene and thus creates and holds all components of it.
 */
final class Scene2VC: BaseViewController {
	/// The interactor which binds the display to the logic.
	private var interactor: Scene2Interactor?

	/// The injected dependencies.
	private let dependencies: Scene2VCDependencyResolver

	// The model parameter to set up the logic.
	// weaver: setupModel <= Scene2Setup

	// A strong reference to the navigator.
	// weaver: navigator = Scene2Navigator <- Scene2NavigatorInterface
	// weaver: navigator.scope = .container
	private var navigator: Scene2Navigator {
		guard let dependency = dependencies.navigator as? Scene2Navigator else { fatalError() }
		return dependency
	}

	// A strong reference to the presenter.
	// weaver: presenter = Scene2Presenter <- Scene2PresenterInterface
	// weaver: presenter.scope = .container
	private var presenter: Scene2Presenter {
		guard let dependency = dependencies.presenter as? Scene2Presenter else { fatalError() }
		return dependency
	}

	// A strong reference to the business logic.
	// weaver: logic2 = Scene2Logic <- Scene2LogicInterface
	// weaver: logic2.scope = .container
	private var logic: Scene2Logic {
		// TODO: Remove unused logic parameter as soon as weaver supports it
		guard let dependency = dependencies.logic2(setupModel: dependencies.setupModel) as? Scene2Logic else { fatalError() }
		return dependency
	}

	required init(injecting dependencies: Scene2VCDependencyResolver) {
		self.dependencies = dependencies
		super.init()
		navigator.viewController = self
		presenter.viewController = self
	}

	// MARK: - View

	override func loadView() {
		let sceneView = Scene2View()
		view = sceneView
		presenter.view = sceneView
		interactor = Scene2Interactor(view: sceneView, logic: logic)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if isMovingToParent || isBeingPresented {
			// Show navigation bar.
			navigationController?.isNavigationBarHidden = false

			// Request initial display data.
			logic.updateDisplay()
		}
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if isMovingFromParent || isBeingDismissed {
			// Hide navigation bar.
			navigationController?.isNavigationBarHidden = true

			// Scene is transitioning back to the previous.
			logic.updateParentScene()
		}
	}

	override var shouldAutorotate: Bool {
		switch logic.state.displayRotation {
		case .locked:
			return false
		case .possible:
			return true
		}
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		coordinator.animate(alongsideTransition: nil) { [weak self] _ in
			self?.logic.displayRotated()
		}
	}
}
