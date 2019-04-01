/// The scene's setup model.
struct Scene2Setup {
	/// The headline selected by the parent scene.
	let headline: String
	/// The initial value for the counter to pass forth and back.
	let counter: Int
	/// The closure for passing back some values.
	let callback: Scene2Callback
}

typealias Scene2Callback = (_ model: Scene2CallbackModel) -> Void

/// The model to pass back to the parent controller.
struct Scene2CallbackModel {
	/// The new counter value.
	let counter: Int
}
