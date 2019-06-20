import Foundation

extension Date {
	/**
	 Returns the date with the start of the week.

	 - parameter calendar: The calendar to use for calculations.
	 - returns: The date which is the first day of the week for this date.
	 */
	public func startOfWeek(calendar: Calendar = Calendar.current) -> Date {
		let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
		guard let firstOfWeek = calendar.date(from: components) else { fatalError() }
		return firstOfWeek
	}

	/**
	 Returns the date with the start of the month.

	 - parameter calendar: The calendar to use for calculations.
	 - returns: The date which is the first day of the month for this date.
	 */
	public func startOfMonth(calendar: Calendar = Calendar.current) -> Date {
		let components = calendar.dateComponents([.year, .month], from: self)
		guard let firstOfMonth = calendar.date(from: components) else { fatalError() }
		return firstOfMonth
	}

	/**
	 Returns the date with the end of the month.

	 - parameter calendar: The calendar to use for calculations.
	 - returns: The date which is the last day of the month for this date.
	 */
	public func endOfMonth(calendar: Calendar = Calendar.current) -> Date {
		let firstOfMonth = startOfMonth(calendar: calendar)
		var components = DateComponents()
		components.month = 1
		components.day = -1
		guard let lastOfMonth = calendar.date(byAdding: components, to: firstOfMonth) else { fatalError() }
		return lastOfMonth
	}

	/**
	 Checks whether two this and another date fall in the same month.

	 - parameter date: The date to compare with.
	 - parameter calendar: The calendar to use for calculations.
	 - returns: `true` if both dates share the same month and year, otherwise `false`.
	 */
	public func isInSameMonth(date: Date, calendar: Calendar = Calendar.current) -> Bool {
		return calendar.isDate(self, equalTo: date, toGranularity: .month)
	}

	/**
	 Returns the amount of months from another date.

	 - parameter date: The other date to compare with.
	 - parameter calendar: The calendar to use for calculations.
	 - returns: The number of months between (negative values when the other date is before this).
	 */
	public func months(to date: Date, calendar: Calendar = Calendar.current) -> Int {
		return calendar.dateComponents([.month], from: self, to: date).month ?? 0
	}

	/**
	 Returns the number of days the month has.

	 - parameter calendar: The calendar to use for calculations.
	 - returns: The number of days of the month.
	 */
	public func daysInMonth(calendar: Calendar = Calendar.current) -> Int {
		guard let range = calendar.range(of: .day, in: .month, for: self) else { fatalError() }
		return range.count
	}

	/**
	 Returns the string representation of this date in a custom format.

	 - parameter dateFormat: The format in which to print the date, e.g. "yyyy/MM/dd".
	 - parameter calendar: The calendar to use.
	 - returns: The string representation.
	 */
	public func string(withFormat dateFormat: String, calendar: Calendar = Calendar.current) -> String {
		let formatter = DateFormatter()
		formatter.calendar = calendar
		formatter.dateFormat = dateFormat
		return formatter.string(from: self)
	}
}
