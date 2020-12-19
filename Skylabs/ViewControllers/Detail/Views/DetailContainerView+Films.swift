import UIKit

extension DetailContainerView {
    func configureFilms(with descriptionContents: [FilmViewContent]) {
        descriptionContents.forEach {
            stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Title",
                                                                            description: $0.title)))
            stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Release date",
                                                                            description: $0.releaseDate)))
            stackView.addArrangedSubview(DescriptionView(viewContent: .init(title: "Opening Crawl",
                                                                            description: $0.openingCrawl)))
            let separator = UIView()
            separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
            separator.backgroundColor = .gray
            stackView.addArrangedSubview(separator)
        }
        stackView.addArrangedSubview(UIView())
    }
}
