import Kingfisher

class TableCell: UITableViewCell {

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        return view
    }()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 16,
                                    left: 0,
                                    bottom: 16,
                                    right: 0)
        return stack
    }()
    let titleLabel: UILabel = {
        let label = TitleLabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000),
                                                      for: .horizontal)
        return label
    }()
    let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        stackView.addArrangedSubview(avatarView)
        stackView.addArrangedSubview(titleLabel)

        addSubview(containerView)
        containerView.addContentView(stackView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -16),
            containerView.topAnchor.constraint(equalTo: topAnchor,
                                               constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                  constant: -8)
        ])
    }
}

extension TableCell {
    func configure(from people: People) {
        avatarView.setPeopleAvatar(from: people.id)
        titleLabel.text = people.name
    }
}

