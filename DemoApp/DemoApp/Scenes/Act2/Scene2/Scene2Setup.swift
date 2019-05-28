extension SetupModel {
	/// The scene's setup model.
	struct Scene2 {
		/// The headline selected by the parent scene.
		let headline: String
		/// The total number of rotations.
		let numberOfRotations: Int
		/// The closure for passing back some values to the previous scene.
		let callback: Scene2Callback
	}

	typealias Scene2Callback = (_ model: Scene2Result) -> Void

	/// The model to pass back to the parent controller.
	struct Scene2Result {
		/// The new total number of rotations.
		let numberOfRotations: Int
	}
}
