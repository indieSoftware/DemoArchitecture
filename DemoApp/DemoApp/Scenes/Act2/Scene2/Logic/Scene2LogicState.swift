extension Scene2Model {
	/// The scene's actual state.
	struct LogicState {
		/// Whether rotation is currently locked or unlocked.
		var displayRotation = DisplayRotation.possible
		/// The current total number of rotations applied to the app.
		var numberOfRotations = 0
	}
}
