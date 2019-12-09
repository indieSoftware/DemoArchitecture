import UIKit

/**
 A replacement construct for a simple delegate pattern or a callback closure.

 Use this instead of a simple delegate closure where the developer might forget to provide a `[weak self]` in the closure,
 e.g. `delegate = { [weak self] image in }`.
 With this approach the provided closure has automatically a not-retained strong reference to the object.

 Usage example:

 ```
 // Provide possibility to register.
 let didDownload = DelegatedCall<UIImage>()

 // Register as delegate.
 didDownload.setDelegate(to: self) { (strongSelf, image) in }

 // Inform registered object.
 didDownload.callback?(image)
 ```

 See: https://medium.com/anysuggestion/preventing-memory-leaks-with-swift-compile-time-safety-49b845df4dc6
 */
public final class DelegatedCall<Input> {
	// MARK: - Delegate

	/// The callback called when the delegate should fire.
	private(set) var callback: ((Input) -> Void)?

	/**
	 Sets the `callback` property with the delegate for calling when firing.

	 - parameter object: The delegate object to inform.
	 - parameter callback: The closure to call when the delegate triggers.
	 - parameter strongSelf: A non-retaining strong reference to the delegate callee.
	 - parameter delivery: The object to deliver to the delegate.
	 */
	public func setDelegate<Object: AnyObject>(
		to object: Object,
		with callback: @escaping (_ strongSelf: Object, _ delivery: Input) -> Void
	) {
		self.callback = { [weak object] input in
			guard let object = object else {
				return
			}
			callback(object, input)
		}
	}
}
