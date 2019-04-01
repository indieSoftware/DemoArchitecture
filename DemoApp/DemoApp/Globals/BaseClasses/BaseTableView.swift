import UIKit

/**
 A base class for table views.
 Derive from this class instead of `UITableView` directly.
 This class can cancel touches on controler like buttons so they don't interfere with the scroll behavior anymore.
 */
class BaseTableView: UITableView {
	// MARK: - Touch cancelling

	/**
	 Flag whether to cancel touches on all controls.

	 Normally a scroll view will not cancel touches on `UIButton`s or other specific controls.
	 To generally switch this on assign set this property to `true` (default), `false` do have the default behaviour.
	 */
	var cancelTouchesOnControls = true

	/**
	 A list of classes to cancel touches on instances of them when dragging.

	 Normally a scroll view will not cancel touches on `UIButton`s, though by adding the class name of UIButton to this list will do this.
	 The method `touchesShouldCancel(in:)` will return `true` if the touch is on a class which is listed in this array.
	 For this to happen the exact same class has to be added, so adding a superclass won't match to child classes.

	 Example of use:

	 ```
	 tableView.classesToCancelTouchesOn.append(UIButton.self)
	 ```

	 This list may be used in conjunction with `viewsToCancelTouchesOn` and offers the possibility to cancel all types of objects at once.
	 So to cancel touches on all objects of the same type use this list, to cancel touches on a specific object only use `viewsToCancelTouchesOn` instead.
	 */
	var classesToCancelTouchesOn = [AnyClass]()

	/**
	 A list of `UIView` objects on which to cancel touches when dragging.

	 Normally a scroll view will not cancel touches on `UIButton`s, though by adding the object to this list will do this.
	 The method `touchesShouldCancel(in:)` will return `true` if the touch is on an object added to this list.

	 Example of use:

	 ```
	 tableView.viewsToCancelTouchesOn.append(myButton)
	 ```

	 This list may be used in conjunction with `classesToCancelTouchesOn` and offers the possibility to precisely exclude certain objects.
	 So to cancel touches only on one object use this list, to cancel touches on all objects of the same type, use `classesToCancelTouchesOn` instead.
	 */
	var viewsToCancelTouchesOn = [UIView]()

	/**
	 Cancels a touch when either the view itself is in the list of `viewsToCancelTouchesOn` or its class is listed in `classesToCancelTouchesOn`.
	 Otherwise the request is passed to `super`.
	 */
	override func touchesShouldCancel(in view: UIView) -> Bool {
		// General flag set to cancel on all controls.
		if cancelTouchesOnControls, view is UIControl {
			return true
		}

		// Cancel touch if the view's class' name is in the list.
		for classInList in classesToCancelTouchesOn where type(of: view) == classInList {
			return true
		}

		// Cancel touch if the view itself is in the list.
		for viewInList in viewsToCancelTouchesOn where view == viewInList {
			return true
		}

		// Forward decision to the superview.
		return super.touchesShouldCancel(in: view)
	}
}
