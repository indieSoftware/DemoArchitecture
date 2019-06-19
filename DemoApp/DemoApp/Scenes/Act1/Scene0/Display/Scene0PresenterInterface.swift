import UIKit

/// The interface for presenting something in the view.
protocol Scene0PresenterInterface: AnyObject {
	/**
	 Shows the splash screen with an animation.

	 - parameter completion: The completion handler called when the animation has fully ended.
	 */
	func showSplash(completion: @escaping () -> Void)
}

extension Scene0Model {}
