import UIKit

/**
 The view controller which is the main module for this scene and thus creates and holds all components of it.
 */
final class ___VARIABLE_sceneName___VC: BaseViewController {
	/// A strong reference to the interactor which binds the display to the logic.
	private var interactor: ___VARIABLE_sceneName___Interactor?

	// A strong reference to the presenter which presents data on the view.
	private let presenter = ___VARIABLE_sceneName___Presenter()

	// A strong reference to the navigator which is responsible for routing.
	private let navigator: ___VARIABLE_sceneName___Navigator

	// A strong reference to the business logic.
	private let logic: ___VARIABLE_sceneName___Logic

	required init(setupModel: SetupModel.___VARIABLE_sceneName___, dependencies actDependencies: ___VARIABLE_actName___DCInterface) {
		navigator = ___VARIABLE_sceneName___Navigator(dependencies: actDependencies)
		let logicDependencies = ___VARIABLE_sceneName___Model.LogicDependencies(
			setupModel: setupModel,
			presenter: presenter,
			navigator: navigator,
			actDependencies: actDependencies
		)
		logic = ___VARIABLE_sceneName___Logic(dependencies: logicDependencies)
		super.init()
		navigator.viewController = self
		presenter.viewController = self
	}

	// MARK: - View

	override func loadView() {
		let sceneView = ___VARIABLE_sceneName___View()
		view = sceneView
		presenter.view = sceneView
		interactor = ___VARIABLE_sceneName___Interactor(view: sceneView, logic: logic)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if isMovingToParent || isBeingPresented {
			// Request initial display data.
			logic.updateDisplay()
		}
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if isMovingFromParent || isBeingDismissed {
			// Scene is transitioning back to the previous.
			logic.updateParentScene()
		}
	}
}
