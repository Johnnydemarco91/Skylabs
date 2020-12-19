import UIKit

class CollectionCell: UICollectionViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        return view
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    let titleLabel: UILabel = {
        let label = TitleLabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000),
                                                      for: .vertical)
        return label
    }()
    let avatarView: UIImageView = {
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
        backgroundColor = .clear

        stackView.addArrangedSubview(avatarView)
        stackView.addArrangedSubview(titleLabel)
        addContentView(containerView)
        containerView.addContentView(stackView)
    }
}

extension CollectionCell {
    func configure(from person: Person) {
        avatarView.setPersonAvatar(from: person.id)
        titleLabel.text = person.name
    }
}
