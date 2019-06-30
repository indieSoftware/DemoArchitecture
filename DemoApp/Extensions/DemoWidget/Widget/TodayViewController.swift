import NotificationCenter
import Shared
import UIKit

class TodayViewController: UIViewController, NCWidgetProviding {
	// weaver: forceGenerate = Bool

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view from its nib.
	}

	func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
		// Perform any setup necessary in order to update the view.

		// If an error is encountered, use NCUpdateResult.Failed
		// If there's no update required, use NCUpdateResult.NoData
		// If there's an update, use NCUpdateResult.NewData

		completionHandler(NCUpdateResult.newData)
	}
}
