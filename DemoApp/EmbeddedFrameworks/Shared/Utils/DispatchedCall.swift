import Foundation

/**
 A dispatch worker item which executes a block after a given time,
 but only as long as this worker object lives and hasn't been cancelled manually.

 Usage example:

 ```
 // Create a new dispatched call worker ready to enqueue the block for later execution.
 lazy var worker = DispatchedCall(for: self) { strongSelf in }

 // Enqueue the block for beeing executed in 1 second.
 worker.enqueue(for: 1)

 // Cancel execution of the block.
 worker.cancel()

 // Enqueue the block again, but for 2 seconds this time.
 worker.enqueue(for: 2)

 // Automatically cancels the block execution.
 worker = nil
 ```
 */
public final class DispatchedCall {
	// MARK: - Init

	/// The cancellable worker item added to the dispatch queue which runs the dispatch block.
	private var dispatchWorkerItem: DispatchWorkItem?

	/// The block provided for the dispatch worker to be executed.
	private let dispatchWorkerBlock: () -> Void

	/**
	 Initializes a new dispatch call, but doesn't enqueue it.

	 - parameter object: The block holder provided as a non-retained, but strong parameter in the block.
	 - parameter block: The block to call after the time has passed.
	 - parameter strongSelf: The non-retained reference of the block holder.
	 */
	public init<Object: AnyObject>(for object: Object, block: @escaping (_ strongSelf: Object) -> Void) {
		dispatchWorkerBlock = { [weak object] in
			guard let object = object else {
				return
			}
			block(object)
		}
	}

	deinit {
		cancel()
	}

	// MARK: - State manipulation

	/**
	 Enqueues a new dispatch worker item for executing the provided dispatch block after some time.

	 Calling this method again automatically cancels any old calls.

	 - parameter delay: The delay time in seconds when to execute the block. Must be greater or equal 0.
	 - parameter queue: The queue on which the block gets executed. Defaults to the main queue.
	 */
	public func enqueue(for delay: TimeInterval, on queue: DispatchQueue = .main) {
		precondition(delay >= 0)

		// Cancel any old worker.
		dispatchWorkerItem?.cancel()

		// Create a new worker and enqueue it.
		let worker = DispatchWorkItem { [weak self] in
			guard let strongSelf = self else { return }
			guard let worker = strongSelf.dispatchWorkerItem, !worker.isCancelled else { return }
			strongSelf.dispatchWorkerBlock()
		}
		dispatchWorkerItem = worker
		queue.asyncAfter(deadline: .now() + delay, execute: worker)
	}

	/**
	 Cancels the execution of a block.

	 Does nothing when the block has been already cancelled or executed.
	 */
	public func cancel() {
		dispatchWorkerItem?.cancel()
		dispatchWorkerItem = nil
	}
}
