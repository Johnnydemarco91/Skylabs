import UIKit

extension DetailContainerView {
    func configureVehicles(with descriptionContents: [VehicleViewContent]) {
        descriptionContents.forEach {
            stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Name",
                                                                            description: $0.name)))
            stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Model",
                                                                            description: $0.model)))
            stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Manufacturer",
                                                                            description: $0.manufacturer)))
            stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Length",
                                                                            description: $0.length)))
            stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Max atmosphere speed",
                                                                            description: $0.maxAtmospheringSpeed)))

            let separator = UIView()
            separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
            separator.backgroundColor = .gray
            stackView.addArrangedSubview(separator)
        }
        stackView.addArrangedSubview(UIView())
    }
}

