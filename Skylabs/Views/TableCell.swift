import Kingfisher

class TableCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000),
                                                      for: .horizontal)
        return label
    }()

    let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16,
                                        left: 0,
                                        bottom: 16,
                                        right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
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

