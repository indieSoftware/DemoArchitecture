import UIKit

/**
 Wraps the observer token received from `NotificationCenter.addObserver(forName:object:queue:using:)` and unregisters it in deinit.

 This helps to handle notifications with blocks so they unregisters the observer when dealocating.

 Usage example:

 ```
 // Provide a token property.
 var notificationToken: NotificationToken?

 // Add an observer to the notification center and hold the returned token.
 notificationToken = NotificationCenter.default.observe(name: .ANotificationName) { [weak self] notification in }

 // Automatically removes the observer from the notification center.
 notificationToken = nil
 ```

 See: https://oleb.net/blog/2018/01/notificationcenter-removeobserver/
 */
public final class NotificationToken {
	// MARK: - Init

	/// The notification center on which the token is registered.
	private let notificationCenter: NotificationCenter

	/// The token returned by the notification center for de-registering.
	private let token: Any

	/**
	 Initializes the instance for the notification center with the provided register token.

	 - parameter notificationCenter: The notification center used for register.
	 - parameter token: The returned token for de-registering.
	 */
	public init(notificationCenter: NotificationCenter = .default, token: Any) {
		self.notificationCenter = notificationCenter
		self.token = token
	}

	deinit {
		notificationCenter.removeObserver(token)
	}
}

extension NotificationCenter {
	/**
	 Convenience wrapper for `addObserver(forName:object:queue:using:)` that returns a `NotificationToken`.

	 - parameter name: The name of the notification for which to register the observer.
	 - parameter obj: The object whose notifications the observer wants to receive.
	 - parameter queue: The operation queue to which `block` should be added.
	 - parameter block: The block to be executed when the notification is received.
	 - parameter notification: The notification called.
	 */
	public func observe(
		name: NSNotification.Name?, object obj: Any? = nil, queue: OperationQueue? = .main,
		using block: @escaping (_ notification: Notification) -> Void
	) -> NotificationToken {
		let token = addObserver(forName: name, object: obj, queue: queue, using: block)
		return NotificationToken(notificationCenter: self, token: token)
	}
}
