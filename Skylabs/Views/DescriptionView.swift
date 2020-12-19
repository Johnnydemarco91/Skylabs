import UIKit

class DescriptionView: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    private let containerStackView = UIStackView()
    private let titleLabel = TitleLabel()

    private let descriptionLabel: UILabel = {
        let label = DescriptionLabel()
        label.numberOfLines = 0
        return label
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
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(UIView())
        containerStackView.addArrangedSubview(descriptionLabel)
        addContentView(stackView)
        stackView.addArrangedSubview(containerStackView)
    }
}

struct DescriptionViewContent {
    let title: String
    let description: String
}
