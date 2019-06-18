import Shared
import UIKit

/**
 A base view controler to derive from instead directly from UIViewController.
 */
class BaseViewController: UIViewController {
	init() {
		super.init(nibName: nil, bundle: nil)
		commonInit()
	}

	@available(*, unavailable, message: "Instantiating via Xib & Storyboard is prohibited.")
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 A common initializer for this class called by the `init` methods.
	 */
	private func commonInit() {
		// Disable title in back button as init value so a nav controller can use it even when the back view is not yet loaded.
		// navigationItem.backBarButtonItem = UIBarButtonItem(title: String.empty, style: .plain, target: nil, action: nil)
	}

	// MARK: - Segue routing

	@available(*, unavailable, message: "Segues are forbidden.")
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		fatalError("This method is unsupported.")
	}

	@available(*, unavailable, message: "Segues are forbidden.")
	override func performSegue(withIdentifier identifier: String, sender: Any?) {
		fatalError("This method is unsupported.")
	}

	// MARK: - Orientation

	override var shouldAutorotate: Bool {
		return true
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		if UIDevice.isIPad {
			return .all
		} else {
			return .allButUpsideDown
		}
	}

	// MARK: - Status bar

	override var prefersStatusBarHidden: Bool {
		return false
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		// Dark status bar text on light background.
		return .default
	}
}
