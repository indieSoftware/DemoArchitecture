import RxCocoa
import RxSwift
import Shared
import UIKit

class Scene1DefaultCell: BaseCell {
	/// The cell's view to embed into the content view.
	private let cellView = Scene1DefaultCellView()

	override func configureView() {
		embedCellView(cellView)
	}

	// MARK: - Setup

	/// The cell's model.
	private var model: Scene1DefaultCellModel?

	/// The dispose bag for Rx.
	private var disposeBag = DisposeBag()

	/**
	 Sets up the cell.

	 - parameter model: The cell's model.
	 */
	func setup(model: Scene1DefaultCellModel) {
		// Apply model.
		self.model = model
		cellView.titleLabel.text = model.suggestion

		// Reset previous bindings so they don't fire multiple times.
		disposeBag = DisposeBag()

		// Inform delegate about cell button tap.
		cellView.cellButton.rx.tap
			.throttle(Const.Time.defaultDebounceDuration.dispatchTimeInterval, scheduler: MainScheduler.instance) // act immediately, but not too often
			.subscribe(onNext: { _ in
				Log.debug("Cell \(model.suggestion) tapped")
				model.delegate?.cellButtonPressed(cellModel: model)
			}).disposed(by: disposeBag)
	}
}
