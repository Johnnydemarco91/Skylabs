import UIKit

class FillButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .blue
        titleLabel?.textColor = .white
        layer.cornerRadius = 16
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
