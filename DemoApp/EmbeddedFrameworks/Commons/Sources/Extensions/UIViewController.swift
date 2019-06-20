import UIKit

extension UIViewController {
	/**
	 Adds a sub-controller to the hierarchy of this controller.

	 Calls `willMove` and `didMove` on the sub-controller and adds it as a child.
	 While embedding the `viewEmbedding` closure is called which is responsible for adding the
	 controller's view as subview to the view hierarchy and applying any constraints if necessary.

	 - parameter viewController: The sub-controller to embedd into this view controller.
	 - parameter embedView: The closure which has to add the sub-controller's view to the view hierarchy.
	 */
	public func addChild(viewController: UIViewController, embedView: () -> Void) {
		viewController.willMove(toParent: self)
		viewController.view.translatesAutoresizingMaskIntoConstraints = false

		embedView()

		addChild(viewController)
		viewController.didMove(toParent: self)
	}

	/**
	 Removes a sub-controller and its view from the hierarchy.

	 Calls `willMove` and `didMove`and removes the sub-controller's view from its parent.
	 Does nothing if the provided sub-controller is not a child of the view controller.

	 - parameter viewController: The sub-controller to remove from the hierarchy.
	 */
	public func removeChild(_ viewController: UIViewController) {
		guard children.contains(viewController) else { return }

		viewController.willMove(toParent: nil)
		viewController.view.removeFromSuperview()
		viewController.removeFromParent()
		viewController.didMove(toParent: nil)
	}

	/**
	 Removes all sub-controllers from this controller.

	 Calls `removeChild(viewController:)` on each child.
	 */
	public func removeAllChildren() {
		children.forEach { removeChild($0) }
	}
}
