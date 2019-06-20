import UIKit

/// The interface for presenting something in the view.
protocol Scene0PresenterInterface: AnyObject {
	/**
	 Hides the splash screen's title with an animation.

	 - parameter completion: The completion handler called when the animation has fully ended.
	 */
	func hideSplash(completion: @escaping () -> Void)
}

extension Scene0Model {}
