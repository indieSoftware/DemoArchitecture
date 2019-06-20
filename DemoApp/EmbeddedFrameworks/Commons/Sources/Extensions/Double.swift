extension Double {
	/// Converts a Double value given in seconds into a DispatchTimeInterval.milliseconds value.
	public var dispatchTimeInterval: DispatchTimeInterval {
		return DispatchTimeInterval.milliseconds(Int(self * 1000))
	}

	/// Converts a Double value into a TimeInterval value.
	public var timeInterval: TimeInterval {
		return TimeInterval(self)
	}
}
