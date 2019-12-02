import Commons
import UIKit

extension ViewStyle where T: UIButton {
	/// Makes the button solid with a filled color.
	public static var filled: ViewStyle<T> {
		return ViewStyle<T> {
			$0.setTitleColor(R.color.buttonText(), for: .normal)
			$0.setTitleColor(R.color.buttonTextHighlight(), for: .highlighted)
			$0.backgroundColor = R.color.defaultBackground()
		}
	}

	/// Makes the button have rounded conrners.
	public static var rounded: ViewStyle<T> {
		return ViewStyle<T> {
			$0.layer.cornerRadius = 4.0
		}
	}

	/// Combines the `filled` and `rounded` styles.
	public static var roundedAndFilled: ViewStyle<T> {
		return ViewStyle<T> {
			$0.apply(.rounded).apply(.filled)
		}
	}
}
