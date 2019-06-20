import UIKit

/// The delegate of a `KeyboardController` which gets informed about keyboard appearance changes.
public protocol KeyboardControllerDelegate: AnyObject {
	/**
	 The keyboard currently shows in.
	 This method is called in a `UIView.animate` block and thus animates any view changes accordingly to the keyboard.

	 - parameter keyboardSize: The keyboard's size.
	 */
	func keyboardShows(keyboardSize: CGSize)

	/**
	 The keyboard has shown up. Showing in has finished.
	 */
	func keyboardShown()

	/**
	 The keyboard currently hides by moving out of view.
	 This method is called in a `UIView.animate` block and thus animates any view changes accordingly to the keyboard.
	 */
	func keyboardHides()

	/**
	 The keyboard has hidden. Hiding has finished.
	 */
	func keyboardHidden()
}

/**
 A controller which informs a delegate about keyboard appearance changes.

 This controller listens to the keyboard notifications and passes the appropriate callbacks to the delegate.
 */
public final class KeyboardController {
	// MARK: - Properties

	/// The delegate to inform about keyboard appearance changes.
	public weak var delegate: KeyboardControllerDelegate?

	/**
	 Initializes the controller to listen for the notifications.

	 To get any benefit from this controller the delegate has to be registered.
	 */
	public init() {
		// Register for keyboard notifications.
		keyboardShowToken = NotificationCenter.default.observe(name: UIResponder.keyboardWillShowNotification, using: keyboardShowBlock)
		keyboardHideToken = NotificationCenter.default.observe(name: UIResponder.keyboardWillHideNotification, using: keyboardHideBlock)
	}

	/// The notification token for the show keyboard notification.
	private var keyboardShowToken: NotificationToken?

	/// The block to invoce when the keyboard shows.
	private lazy var keyboardShowBlock: (Notification) -> Void = { [weak self] notification in
		guard let delegate = self?.delegate else { return }
		guard let notificationInfo = notification.userInfo,
			let keyboardSize = (notificationInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
			let animationDuration = (notificationInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
			return
		}

		// Reduce text view's frame to fit the keyboard.
		// UIKeyboardAnimationCurveUserInfoKey doesn't return with 7 a valid curve so we use as a workaround a hard coded.
		let animationCurveOptions = UIView.AnimationOptions.curveEaseOut
		UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurveOptions, animations: {
			delegate.keyboardShows(keyboardSize: keyboardSize.size)
		}, completion: { _ in
			delegate.keyboardShown()
		})
	}

	/// The notification token for the hide keyboard notification.
	private var keyboardHideToken: NotificationToken?

	/// The block to invoce when the keyboard hides.
	private lazy var keyboardHideBlock: (Notification) -> Void = { [weak self] notification in
		guard let delegate = self?.delegate else { return }
		guard let notificationInfo = notification.userInfo,
			let animationDuration = (notificationInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
			return
		}

		// Reduce text view's frame to fit the keyboard.
		// UIKeyboardAnimationCurveUserInfoKey doesn't return with 7 a valid curve so we use as a workaround a hard coded.
		let animationCurveOptions = UIView.AnimationOptions.curveEaseOut
		UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurveOptions, animations: {
			delegate.keyboardHides()
		}, completion: { _ in
			delegate.keyboardHidden()
		})
	}
}
