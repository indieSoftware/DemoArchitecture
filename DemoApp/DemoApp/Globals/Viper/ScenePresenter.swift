import UIKit

protocol ScenePresenter: AnyObject {
	func present(viewController: UIViewController)
}
