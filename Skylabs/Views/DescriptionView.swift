import UIKit

class DescriptionView: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()

    private let horizontalStackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let separatorView: UIView = {
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = .gray
        return separator
    }()

    private let viewContent: DescriptionViewContent

    init(viewContent: DescriptionViewContent) {
        self.viewContent = viewContent
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        titleLabel.text = viewContent.title
        descriptionLabel.text = viewContent.description
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(UIView())
        horizontalStackView.addArrangedSubview(descriptionLabel)
        addContentView(stackView)
        stackView.addArrangedSubview(horizontalStackView)
        stackView.addArrangedSubview(separatorView)
    }
}

struct DescriptionViewContent {
    let title: String
    let description: String
}
