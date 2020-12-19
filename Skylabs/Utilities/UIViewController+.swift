import UIKit

extension UIViewController {
    func showLoading() {
        DispatchQueue.main.async {
            self.view.addContentView(LoadingView.shared)
            LoadingView.shared.activityIndicator.startAnimating()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            LoadingView.shared.activityIndicator.stopAnimating()
            LoadingView.shared.removeFromSuperview()
        }
    }
}
