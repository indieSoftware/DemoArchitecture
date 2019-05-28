import AppFolder
import Shared
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
	/// The reference to the window.
	var window: UIWindow?
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Setup logger.
		Log.setup()
		Log.debug("App's home directory:\n\n\(AppFolder.baseURL.path)\n\n------")

		// Create window.
		let window = UIWindow(frame: UIScreen.main.bounds)
		self.window = window
		window.backgroundColor = R.color.defaultBackground()

		// Prepare initial act & scene.
		let dependencies = Act1Dependencies()
		let setupModel = SetupModel.Scene1()
		let scene = dependencies.scene(Act1Scene.scene1(setupModel))
		let navController = BaseNavigationController(rootViewController: scene)
		navController.isNavigationBarHidden = true

		// Show the scene.
		window.rootViewController = navController
		window.makeKeyAndVisible()

		// Make sure device orientation changes are broadcasted.
		UIDevice.current.beginGeneratingDeviceOrientationNotifications()

		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {}

	func applicationDidEnterBackground(_ application: UIApplication) {}

	func applicationWillEnterForeground(_ application: UIApplication) {}

	func applicationDidBecomeActive(_ application: UIApplication) {}

	func applicationWillTerminate(_ application: UIApplication) {}
}
