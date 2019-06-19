import UIKit

/**
 The view controller which is the main module for this scene and thus creates and holds all components of it.
 */
final class Scene0VC: BaseViewController {
	/// A strong reference to the interactor which binds the display to the logic.
	private var interactor: Scene0Interactor?

	// A strong reference to the presenter which presents data on the view.
	private let presenter = Scene0Presenter()

	// A strong reference to the navigator which is responsible for routing.
	private let navigator: Scene0Navigator

	// A strong reference to the business logic.
	private let logic: Scene0Logic

	required init(setupModel: SetupModel.Scene0, dependencies actDependencies: Act1DCInterface) {
		navigator = Scene0Navigator(dependencies: actDependencies)
		let logicDependencies = Scene0Model.LogicDependencies(
			setupModel: setupModel,
			presenter: presenter,
			navigator: navigator,
			actDependencies: actDependencies
		)
		logic = Scene0Logic(dependencies: logicDependencies)
		super.init()
		navigator.viewController = self
		presenter.viewController = self
	}

	// MARK: - View

	override func loadView() {
		let sceneView = Scene0View()
		view = sceneView
		presenter.view = sceneView
		interactor = Scene0Interactor(view: sceneView, logic: logic)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		logic.start()
	}
}
