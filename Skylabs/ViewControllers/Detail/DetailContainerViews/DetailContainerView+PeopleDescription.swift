import UIKit

extension DetailContainerView {
    func configureDescription(with descriptionContent: PersonDescriptionViewContent) {
        let avatarView = UIImageView()
        avatarView.contentMode = .scaleAspectFit
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.setPersonAvatar(from: descriptionContent.id)
        stackView.addArrangedSubview(avatarView)
        stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Birthday",
                                                                        description: descriptionContent.birthyear)))
        stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Height",
                                                                        description: descriptionContent.height)))
        stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Mass",
                                                                        description: descriptionContent.mass)))
        stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Gender",
                                                                        description: descriptionContent.gender)))
        stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Hair Color",
                                                                        description: descriptionContent.hairColor)))
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = .gray
        stackView.addArrangedSubview(separator)
        stackView.addArrangedSubview(UIView())
    }
}
