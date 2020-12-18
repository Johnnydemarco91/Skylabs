import UIKit

extension UINavigationController {
    static func createNavigation(with rootVC: UIViewController) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.setBackgroundImage(nil,
                                               for: .default)
        navVC.navigationBar.shadowImage = UIImage()
        return navVC
    }
}
