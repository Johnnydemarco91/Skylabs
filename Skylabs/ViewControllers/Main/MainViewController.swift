import UIKit

class MainViewController: UIViewController {
    private let tableButton: UIButton = {
        let button = FillButton()
        button.setTitle("List",
                        for: .normal)
        button.addTarget(self,
                         action: #selector(tableButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private let collectionButton: UIButton = {
        let button = FillButton()
        button.setTitle("Collection",
                        for: .normal)
        button.addTarget(self,
                         action: #selector(collectionButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Home"
        setupUI()
    }

    private func setupUI() {
        stackView.addArrangedSubview(tableButton)
        stackView.addArrangedSubview(collectionButton)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -16)
        ])
    }
}

extension MainViewController {
    @objc
    func tableButtonTapped() {
        navigationController?.pushViewController(StarWarsPeopleViewController(viewModel: .init(layout: .list)),
                                                 animated: true)
    }
    
    @objc
    func collectionButtonTapped() {
        navigationController?.pushViewController(StarWarsPeopleViewController(viewModel: .init(layout: .collection)),
                                                 animated: true)
    }
}
