import UIKit

enum SegmentedControlDetail: Int, CaseIterable {
    case description = 0
    case films
    case vehicles

    var title: String {
        switch self {
        case .description:
            return "Description"
        case .films:
            return "Films"
        case .vehicles:
            return "Vehicles"
        }
    }
}

class PeopleDetailViewController: UIViewController {
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        SegmentedControlDetail.allCases.forEach { segmentedControl.insertSegment(withTitle: $0.title,
                                                                                 at: $0.rawValue,
                                                                                 animated: true) }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 8
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    let containerView: UIView = {
        let scroll = UIView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    let viewModel: PeopleDetailViewModel

    init(viewModel: PeopleDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigation()
        setupUI()
        setupSegmentedControl()
    }

    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        view.addContentView(stackView)

        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(containerView)
    }

    private func setupNavigation() {
        title = viewModel.people.name
        guard navigationController?.viewControllers.count == 1 else {
            return
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                            target: self,
                                                            action: #selector(close))
    }

    private func setupSegmentedControl() {
        segmentedControl.addTarget(self,
                                   action: #selector(selectedSegmentControl(_:)),
                                   for: .valueChanged)
        guard let detail = SegmentedControlDetail(rawValue: segmentedControl.selectedSegmentIndex) else {
            return
        }
        handleContainerView(for: detail)
    }

    @objc
    func close() {
        dismiss(animated: true)
    }

    func handleContainerView(for detail: SegmentedControlDetail) {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        switch detail {
        case .description:
            let descriptionView = DetailContainerView()
            descriptionView.configureDescription(with: PeopleDescriptionViewContent.create(from: viewModel.people))
            containerView.addContentView(descriptionView)
            break
        case .films:
            break
        case .vehicles:
            break
        }
    }

    @objc
    func selectedSegmentControl(_ sender: UISegmentedControl) {
        guard let detail = SegmentedControlDetail(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        handleContainerView(for: detail)
    }
}
