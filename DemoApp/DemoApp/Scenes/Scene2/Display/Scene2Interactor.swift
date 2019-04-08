import RxCocoa
import RxSwift
import Shared

/// Responsible for delivering any user inputs to the logic.
final class Scene2Interactor {
	/// A reference to the view to recive inputs from.
	private unowned let view: Scene2View

	/// A reference to the logic to deliver actions to.
	private unowned let logic: Scene2LogicInterface

	/// The dispose bag for Rx.
	private let disposeBag = DisposeBag()

	/**
	 Initializes the interactor with not-retained references to the view and the logic.

	 - parameter view: The view to receive inputs from. Will be referenced as unowned.
	 - parameter logic: The logic to deliver actions to. Will be referenced as unowned.
	 */
	init(view: Scene2View, logic: Scene2LogicInterface) {
		self.view = view
		self.logic = logic

		// Reset counter and dismiss scene when pressing the dismiss button.
		view.dismissButton.rx
			// React on tap actions.
			.tap
			// Act immediately, but not too often.
			.throttle(Const.Time.defaultDebounceDuration, scheduler: MainScheduler.instance)
			.subscribe(onNext: { _ in
				logic.resetAndDismiss()
			}).disposed(by: disposeBag)

		// Toggle rotation lock state when pressing the switch.
		view.rotationLockSwitch.rx
			// Trigger on switch state changes.
			.isOn
			// Ignore first event on registration.
			.changed
			.subscribe(onNext: { enabled in
				let lockState: DisplayRotation = enabled ? .possible : .locked
				logic.rotationLockChanged(lockState: lockState)
			}).disposed(by: disposeBag)
	}
}
