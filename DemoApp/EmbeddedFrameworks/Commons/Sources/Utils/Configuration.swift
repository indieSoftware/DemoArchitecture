import Foundation

/**
 Configures an object passed as a parameter to the configuration closure.

 Inspired by [SwiftBySundell](https://www.swiftbysundell.com/articles/encapsulating-configuration-code-in-swift/)

 Example of usage:

 ```
 private static let dateFormatter = configure(DateFormatter()) {
     $0.dateFormat = "yyyy-MM-dd HH:mm"
 }
 ```

 Instead of:

 ```
 private static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter
 }()
 ```

 - parameters:
    - object: The object to configure.
    - closure: The closure executed to configure the object. The closure's paramter is the provided object.
 - returns: The configured object.
 */
public func configure<T>(_ object: T, using closure: (inout T) -> Void) -> T {
	var object = object
	closure(&object)
	return object
}
