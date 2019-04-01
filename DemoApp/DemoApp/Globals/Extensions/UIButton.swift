import UIKit

extension UIButton {
	/// The minimal size each button should have. Defaults to 44 x 44 according to Apple's guidelines.
	static var buttonMinSize = CGSize(width: 44, height: 44)

	/**
	 Enlarges the hit detection area for each button to at least have the min size.
	 Changes nothing if the button is equal or larger to the min size, otherwise touches up to the min size
	 but outside of this button are also treated as inside.
	 */
	open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let buttonSize = frame.size
		let widthToAdd = (UIButton.buttonMinSize.width - buttonSize.width > 0) ? UIButton.buttonMinSize.width - buttonSize.width : 0
		let heightToAdd = (UIButton.buttonMinSize.height - buttonSize.height > 0) ? UIButton.buttonMinSize.height - buttonSize.height : 0
		let largerFrame = CGRect(x: 0 - (widthToAdd / 2), y: 0 - (heightToAdd / 2), width: buttonSize.width + widthToAdd, height: buttonSize.height + heightToAdd)
		return largerFrame.contains(point)
	}

	open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		guard isEnabled, !isHidden else { return nil }
		return self.point(inside: point, with: event) ? self : nil
	}
}
