import UIKit

extension UIView {
    func addContentView(_ subView: UIView) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor),
            subView.leftAnchor.constraint(equalTo: leftAnchor),
            subView.rightAnchor.constraint(equalTo: rightAnchor)])
    }
}
