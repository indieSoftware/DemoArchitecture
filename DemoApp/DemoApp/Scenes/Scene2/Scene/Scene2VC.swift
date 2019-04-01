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

	// TODO: add if necessary
	/// weaver: settings <- InternalSettingsInterface

	// A strong reference to the navigator.
	// weaver: navigator = Scene2Navigator
	// weaver: navigator.scope = .container

	// A strong reference to the presenter.
	// weaver: presenter = Scene2Presenter
	// weaver: presenter.scope = .container

	// A strong reference to the business logic.
	// TODO: rename logic2 into logic
	// weaver: logic2 = Scene2Logic
	// weaver: logic2.scope = .container

	required init(injecting dependencies: Scene2VCDependencyResolver) {
		self.dependencies = dependencies
		super.init()
		dependencies.navigator.viewController = self
		dependencies.presenter.viewController = self
	}

	// MARK: - View

	override func loadView() {
		let sceneView = Scene2View()
		view = sceneView
		let logic = dependencies.logic2(setupModel: dependencies.setupModel) // TODO: remove
		dependencies.presenter.view = sceneView
		interactor = Scene2Interactor(view: sceneView, logic: logic)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Request initial display data.
		let logic = dependencies.logic2(setupModel: dependencies.setupModel) // TODO: remove
		logic.updateDisplay()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if isMovingFromParent || isBeingDismissed {
			// Scene is transitioning back to the previous.
			let logic = dependencies.logic2(setupModel: dependencies.setupModel) // TODO: remove
			logic.updateParentScene()
		}
	}

	override var shouldAutorotate: Bool {
		let logic = dependencies.logic2(setupModel: dependencies.setupModel) // TODO: remove
		switch logic.state.displayRotation {
		case .locked:
			return false
		case .open:
			return true
		}
	}
}
