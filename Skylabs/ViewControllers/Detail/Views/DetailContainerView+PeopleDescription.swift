import UIKit

extension DetailContainerView {
    func configureDescription(with descriptionContent: PeopleDescriptionViewContent) {
        avatarView.setPeopleAvatar(from: descriptionContent.id)
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
        stackView.addArrangedSubview(UIView())
    }
}
