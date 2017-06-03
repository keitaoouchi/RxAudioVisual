import UIKit
import SwiftyBeaver

let logger = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    configureLogger(logger: logger)

    return true
  }

}

private extension AppDelegate {

  func configureLogger(logger: SwiftyBeaver.Type) {
    let console = ConsoleDestination()

    console.format = "[VideoDebug][$L]$M"
    logger.addDestination(console)
  }

}
