/// Responsible for delivering any user inputs to the logic.
final class ___VARIABLE_sceneName___Interactor {
	/// A reference to the view to recive inputs from.
	private unowned let view: ___VARIABLE_sceneName___View

	/// A reference to the logic to deliver actions to.
	private unowned let logic: ___VARIABLE_sceneName___LogicInterface

	/**
	 Initializes the interactor with not-retained references to the view and the logic.

	 - parameter view: The view to receive inputs from. Will be referenced as unowned.
	 - parameter logic: The logic to deliver actions to. Will be referenced as unowned.
	 */
	init(view: ___VARIABLE_sceneName___View, logic: ___VARIABLE_sceneName___LogicInterface) {
		self.view = view
		self.logic = logic
	}
}
