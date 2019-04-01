import CocoaLumberjack

/**
 A logger, respectively a thin wrapper for the logger to use.
 Only log via this class, don't call the underlaying logger directly,
 so the underlaying implementation can be replaced easily if needed.

 Uses `CocoaLumberjack`.
 */
public final class Log {
	/**
	 Sets up the logging.
	 Has to be called once during app start.
	 */
	public static func setup() {
		// Set `CocoaLumberjack`'s log level, everything on this level or more critical will be logged
		#if DEBUG
			// Log everything in debug mode
			dynamicLogLevel = .all
		#else
			// Log only infos, warnings and errors in release mode
			dynamicLogLevel = .info
		#endif

		// Use the Xcode console for log output
		let logger: DDLogger = DDTTYLogger.sharedInstance // TTY = Xcode console, OS = os_log
		logger.logFormatter = CocoaLumberjackConsoleFormatter()
		DDLog.add(logger)
	}

	/**
	 A debug message to log.

	 This message will only be logged when in debug mode, not in a release version.

	 Use this type of log for development purposes, e.g. for finding bugs, printing states, etc.
	 Normally after developing the feature all of those debug logs have to be removed to not clutter the console with not used messages,
	 but some may be useful for any debug session so they can be left in place.

	 - parameter message: The message to log.
	 - parameter file: The file name where the log has been called. Don't provide a value, will be automatically set.
	 - parameter function: The function name where the log has been called. Don't provide a value, will be automatically set.
	 - parameter line: The line in the code file where the log has been called. Don't provide a value, will be automatically set.
	 */
	public static func debug(
		_ message: String,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line
	) {
		DDLogDebug(
			message,
			context: 0,
			file: file,
			function: function,
			line: line,
			tag: nil,
			asynchronous: true,
			ddlog: DDLog.sharedInstance
		)
	}

	/**
	 An info message to log.

	 **This message will also be logged in a release version.**

	 Use this type of log to track the app's usage by the user so each step can be reproduced by the log.

	 - parameter message: The message to log.
	 - parameter file: The file name where the log has been called. Don't provide a value, will be automatically set.
	 - parameter function: The function name where the log has been called. Don't provide a value, will be automatically set.
	 - parameter line: The line in the code file where the log has been called. Don't provide a value, will be automatically set.
	 */
	public static func info(
		_ message: String,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line
	) {
		DDLogInfo(
			message,
			context: 0,
			file: file,
			function: function,
			line: line,
			tag: nil,
			asynchronous: true,
			ddlog: DDLog.sharedInstance
		)
	}

	/**
	 A warning message to log.

	 **This message will always be logged, even in a release version.**

	 Use this type of log when a recoverable error occured, e.g. a method call returns with an error and this case is gracefully treated,
	 but it may be useful to log the returned error message.
	 So the app won't crash or end in an undefined state and can continue, but the step hasn't passed as desired.

	 - parameter message: The message to log.
	 - parameter file: The file name where the log has been called. Don't provide a value, will be automatically set.
	 - parameter function: The function name where the log has been called. Don't provide a value, will be automatically set.
	 - parameter line: The line in the code file where the log has been called. Don't provide a value, will be automatically set.
	 */
	public static func warn(
		_ message: String,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line
	) {
		DDLogWarn(
			message,
			context: 0,
			file: file,
			function: function,
			line: line,
			tag: nil,
			asynchronous: false,
			ddlog: DDLog.sharedInstance
		)
	}

	/**
	 An error message to log.

	 **This message will always be logged, even in a release version.**

	 Use this type of log when a critical error occured and the app might crash or gets into an undefined state.
	 Normally you don't need to log something in such a case, because you always use `fatalError` or `precondition` instead,
	 so in an ideal world this log should not be needed and never happen...

	 - parameter message: The message to log.
	 - parameter file: The file name where the log has been called. Don't provide a value, will be automatically set.
	 - parameter function: The function name where the log has been called. Don't provide a value, will be automatically set.
	 - parameter line: The line in the code file where the log has been called. Don't provide a value, will be automatically set.
	 */
	public static func error(
		_ message: String,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line
	) {
		DDLogError(
			message,
			context: 0,
			file: file,
			function: function,
			line: line,
			tag: nil,
			asynchronous: false,
			ddlog: DDLog.sharedInstance
		)
	}
}

class CocoaLumberjackConsoleFormatter: NSObject {
	/// The date formatter to use which is cached by this property so no other messes with it.
	private let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.formatterBehavior = .behavior10_4
		formatter.dateFormat = "HH:mm:ss"
		return formatter
	}()
}

extension CocoaLumberjackConsoleFormatter: DDLogFormatter {
	/**
	 Formats given log message.

	 - parameter logMessage: The log message to format.
	 - returns: The formatted string.
	 */
	func format(message logMessage: DDLogMessage) -> String? {
		let timestamp = dateFormatter.string(from: logMessage.timestamp)

		var level: String
		let logFlag = logMessage.flag
		if logFlag.contains(.error) {
			level = "💣 |E|"
		} else if logFlag.contains(.warning) {
			level = "⚠️️ |W|"
		} else if logFlag.contains(.info) {
			level = "🔖 |I|"
		} else if logFlag.contains(.debug) {
			level = "💬 |D|"
		} else if logFlag.contains(.verbose) {
			level = "💭 |V|"
		} else {
			level = "💥 |?|"
		}

		return "\(level) \(timestamp) \(logMessage.fileName.description).\(logMessage.function!.description):\(logMessage.line):\n\(logMessage.message.description)"
	}
}
