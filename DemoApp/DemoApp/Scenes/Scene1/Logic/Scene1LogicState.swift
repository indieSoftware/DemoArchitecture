import Shared

/// The scene's actual state.
struct Scene1LogicState {
	/// The last retrieved suggestions from the server and currently displaying.
	var lastSuggestions: Suggestions?
	/// The total number of rotations which happend to the display among all scenes.
	var numberOfRotations = 0
}
