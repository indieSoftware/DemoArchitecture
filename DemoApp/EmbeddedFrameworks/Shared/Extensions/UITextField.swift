import UIKit

extension UITextField {
	/// The text color of the placeholder text.
	public var placeholderColor: UIColor? {
		get {
			return textColor
		}
		set {
			if let color = newValue {
				attributedPlaceholder = NSAttributedString(string: placeholder ?? String.empty, attributes: [NSAttributedString.Key.foregroundColor: color])
			} else {
				attributedPlaceholder = NSAttributedString(string: placeholder ?? String.empty)
			}
		}
	}
}
