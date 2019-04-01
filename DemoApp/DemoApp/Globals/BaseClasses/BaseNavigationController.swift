import UIKit

/**
 A `UINavigationController` replacement which repsects some controller traits by passing them from the top controller through.
 */
class BaseNavigationController: UINavigationController {
	override var shouldAutorotate: Bool {
		if let topViewController = topViewController {
			return topViewController.shouldAutorotate
		} else {
			return super.shouldAutorotate
		}
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		if let topViewController = topViewController {
			return topViewController.supportedInterfaceOrientations
		} else {
			return super.supportedInterfaceOrientations
		}
	}

	override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
		if let topViewController = topViewController {
			return topViewController.preferredInterfaceOrientationForPresentation
		} else {
			return super.preferredInterfaceOrientationForPresentation
		}
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		if let topViewController = topViewController {
			return topViewController.preferredStatusBarStyle
		} else {
			return super.preferredStatusBarStyle
		}
	}

	override var prefersStatusBarHidden: Bool {
		if let topViewController = topViewController {
			return topViewController.prefersStatusBarHidden
		} else {
			return super.prefersStatusBarHidden
		}
	}
}
