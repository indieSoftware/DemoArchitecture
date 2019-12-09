import UIKit

/**
 A construct replacing the Target-Action-Pairing for `UIControl`s.

 With this approach the provided closure has automatically a not-retained strong reference to the delegate object.

 Usage example:

 ```
 // Provide possibility to register for a button's press action.
 private(set) lazy var onButtonPressed: ControlCallback<UIButton> = {
    ControlCallback(for: button, event: .touchUpInside) { [unowned self] in
        self.button
    }
 }()

 // Register a callback which will be informed about the button gets pressed.
 onButtonPressed.setDelegate(to: self, with: { strongSelf, button in })
 ```
 */
public final class ControlCallback<ReturnType: Any> {
	// MARK: - Properties

	/// The control on which this class is registered.
	private let control: UIControl

	/// The saved closure which returns the desired return value when informing about the control's trigger.
	private let returnValueGetter: () -> ReturnType

	// MARK: - Init

	/**
	 Initializes the calback with a control on which this gets registered for a specific event.

	 - parameter control: The control on which to register, the reference gets retained.
	 - parameter event: The event for which to register.
	 - parameter callback: The closure which returns the desired return value when the control fires.
	 */
	public init(for control: UIControl, event: UIControl.Event, with callback: @escaping () -> ReturnType) {
		self.control = control
		returnValueGetter = callback

		// Register itself as the target for the control as replacement for the delegate.
		control.addTarget(self, action: #selector(controlTrigger), for: event)
	}

	deinit {
		// De-registers itself from the control.
		control.removeTarget(self, action: nil, for: .allEvents)
	}

	// MARK: - Delegate

	/// The callback called when the delegate should fire.
	private var callback: ((ReturnType) -> Void)?

	/**
	 Sets the `callback` property with the delegate for calling when firing.

	 - parameter object: The delegate object to inform.
	 - parameter callback: The closure to call when the delegate triggers.
	 - parameter strongSelf: A non-retaining strong reference to the delegate callee.
	 - parameter value: The object to deliver to the delegate.
	 */
	public func setDelegate<Object: AnyObject>(
		to object: Object,
		with callback: @escaping (_ strongSelf: Object, _ value: ReturnType) -> Void
	) {
		self.callback = { [weak object] returnValue in
			guard let object = object else {
				return
			}
			callback(object, returnValue)
		}
	}

	/**
	 The method which will be called by the control object to inform about the triggered event.
	 */
	@objc private func controlTrigger() {
		callback?(returnValueGetter())
	}
}
