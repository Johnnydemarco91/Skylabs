import UIKit

class DetailContainerView: UIScrollView {
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 16,
                                    left: 16,
                                    bottom: 16,
                                    right: 16)
        stack.spacing = 16
        stack.axis = .vertical
        return stack
    }()

    let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }


    private func setup() {
        addContentView(stackView)
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}
