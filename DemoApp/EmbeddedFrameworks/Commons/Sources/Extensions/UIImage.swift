import UIKit

extension UIImage {
	/**
	 Initializes an image with a view's content.

	 - parameter view: The view to create am image from.
	 */
	public convenience init(view: UIView) {
		UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
		view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		self.init(cgImage: (image?.cgImage)!)
	}
}
