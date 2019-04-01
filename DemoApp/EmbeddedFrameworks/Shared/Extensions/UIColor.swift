import UIKit

extension UIColor {
	/// A random opaque color.
	public static var random: UIColor {
		return UIColor(
			red: CGFloat(arc4random()) / CGFloat(UInt32.max),
			green: CGFloat(arc4random()) / CGFloat(UInt32.max),
			blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
			alpha: 1.0
		)
	}
}
