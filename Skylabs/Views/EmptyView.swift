import UIKit

class EmptyView: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()

    private let titleLabel = TitleLabel()
    private let descriptionLabel: UILabel = {
        let label = DescriptionLabel()
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 16)
        ])
        containerView.addContentView(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
}

extension EmptyView {
    func configure(with image: UIImage? = UIImage(named: "no-data"),
                   title: String,
                   description: String) {
        imageView.image = image
        titleLabel.text = title
        descriptionLabel.text = description
    }

    static func create(with image: UIImage? = UIImage(named: "no-data"),
                       title: String,
                       description: String) -> EmptyView {
        let view = EmptyView()
        view.configure(with: image,
                       title: title,
                       description: description)
        return view
    }
}
