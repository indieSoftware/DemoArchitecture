import Shared
import UIKit

/**
 The view controller which is the main module for this scene and thus creates and holds all components of it.
 */
final class Scene2VC: BaseViewController {
	/// A strong reference to the interactor which binds the display to the logic.
	private var interactor: Scene2Interactor?

	// A strong reference to the presenter which presents data on the view.
	let presenter = Scene2Presenter()

	// A strong reference to the navigator which is responsible for routing.
	let navigator: Scene2Navigator

	// A strong reference to the business logic.
	let logic: Scene2Logic

	required init(setupModel: SetupModel.Scene2, dependencies actDependencies: Act2DependenciesInterface) {
		navigator = Scene2Navigator(dependencies: actDependencies)
		let logicDependencies = Scene2Model.LogicDependencies(
			setupModel: setupModel,
			presenter: presenter,
			navigator: navigator,
			actDependencies: actDependencies
		)
		logic = Scene2Logic(dependencies: logicDependencies)
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
