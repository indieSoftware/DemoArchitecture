import RxCocoa
import RxSwift
import Shared

/// Responsible for delivering any user inputs to the logic.
final class Scene1Interactor {
	/// A reference to the view to recive inputs from.
	private unowned let view: Scene1View

	/// A reference to the logic to deliver actions to.
	private unowned let logic: Scene1LogicInterface

	/// The dispose bag for Rx.
	private let disposeBag = DisposeBag()

	/**
	 Initializes the interactor with not-retained references to the view and the logic.

	 - parameter view: The view to receive inputs from. Will be referenced as unowned.
	 - parameter logic: The logic to deliver actions to. Will be referenced as unowned.
	 */
	init(view: Scene1View, logic: Scene1LogicInterface) {
		self.view = view
		self.logic = logic

		// Search for text when the search text has changed.
		view.searchInputField.rx
			// Trigger only when the text changes.
			.controlEvent([.editingChanged]).asObservable()
			// Wait until no changes arrive anymore.
			.debounce(Const.Time.defaultDebounceDuration, scheduler: MainScheduler.instance)
			.subscribe(onNext: { _ in
				let text = view.searchInputField.text ?? String.empty
				logic.searchForText(text)
			}).disposed(by: disposeBag)

		// Dismiss keyboard when the table view scrolls.
		view.tableView.rx
			// Act on scroll position updates.
			.contentOffset
			// Ignore first event on registration.
			.changed
			// Act immediately, but not too often.
			.throttle(Const.Time.defaultDebounceDuration, scheduler: MainScheduler.instance)
			.subscribe(onNext: { _ in
				logic.dismissKeyboard()
			}).disposed(by: disposeBag)
	}
}
