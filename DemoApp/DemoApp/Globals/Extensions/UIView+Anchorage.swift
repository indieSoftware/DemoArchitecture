import Anchorage
import UIKit

public extension UIView {
	// MARK: - Compression resistance & content hugging

	/// The content compression resistance priority for the horizontal axis.
	var horizontalCompressionResistance: Priority {
		get {
			return Priority(contentCompressionResistancePriority(for: .horizontal).rawValue)
		}
		set {
			setContentCompressionResistancePriority(newValue.value, for: .horizontal)
		}
	}

	/// The content compression resistance priority for the vertical axis.
	var verticalCompressionResistance: Priority {
		get {
			return Priority(contentCompressionResistancePriority(for: .vertical).rawValue)
		}
		set {
			setContentCompressionResistancePriority(newValue.value, for: .vertical)
		}
	}

	/// The content hugging priority for the horizontal axis.
	var horizontalHuggingPriority: Priority {
		get {
			return Priority(contentHuggingPriority(for: .horizontal).rawValue)
		}
		set {
			setContentHuggingPriority(newValue.value, for: .horizontal)
		}
	}

	/// The content hugging priority for the vertical axis.
	var verticalHuggingPriority: Priority {
		get {
			return Priority(contentHuggingPriority(for: .vertical).rawValue)
		}
		set {
			setContentHuggingPriority(newValue.value, for: .vertical)
		}
	}
}
