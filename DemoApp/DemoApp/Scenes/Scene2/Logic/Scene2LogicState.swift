/// The scene's actual state.
struct Scene2LogicState {
	/// Whether rotation is currently locked or not.
	var displayRotation = DisplayRotation.open
	/// The current number to return to the parent controller.
	var counter = 0
}
