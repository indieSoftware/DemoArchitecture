import RxCocoa
import RxSwift

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

		view.dismissButton.rx.tap.subscribe(onNext: { _ in
			logic.resetAndDismiss()
		}).disposed(by: disposeBag)

		view.rotationLockSwitch.rx.isOn.subscribe(onNext: { enabled in
			let lockState: DisplayRotation = enabled ? .open : .locked
			logic.rotationLockChanged(lockState: lockState)
		}).disposed(by: disposeBag)
	}
}
