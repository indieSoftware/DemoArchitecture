extension Const {
	/// All view margins.
	public enum Margin {
		/// The default margin for views which defines only the left and right insets.
		public static let `default` = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)

		/// The margin for cell contents.
		public static let cell = `default`.top(8).bottom(12)
	}
}
