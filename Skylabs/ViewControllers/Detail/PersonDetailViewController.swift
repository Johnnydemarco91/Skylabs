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

class PersonDetailViewController: UIViewController {
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

    let viewModel: PersonDetailViewModel

    init(viewModel: PersonDetailViewModel) {
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
        title = viewModel.person.name
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

    @objc
    func selectedSegmentControl(_ sender: UISegmentedControl) {
        guard let detail = SegmentedControlDetail(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        handleContainerView(for: detail)
    }
}

// MARK: - ContainerView
extension PersonDetailViewController {
    func handleContainerView(for detail: SegmentedControlDetail) {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        let detailContainerView = DetailContainerView()
        switch detail {
        case .description:
            detailContainerView.configureDescription(with: PersonDescriptionViewContent.create(from: viewModel.person))
            containerView.addContentView(detailContainerView)
        case .films:
            guard viewModel.films != nil else {
                showLoading()
                viewModel.prepareFilms {
                    self.hideLoading()
                    self.configureFilms(for: detailContainerView)
                }
                return
            }
            configureFilms(for: detailContainerView)
        case .vehicles:
            guard viewModel.vehicles != nil else {
                showLoading()
                viewModel.prepareVehicles {
                    self.hideLoading()
                    self.configureVehicles(for: detailContainerView)
                }
                return
            }
            configureVehicles(for: detailContainerView)
        }

    }

    func configureFilms(for view: DetailContainerView) {
        var contents = [FilmViewContent]()
        viewModel.films?.forEach { contents.append(.init(title: $0.title,
                                                         releaseDate: $0.releaseDate.year ?? "n/a",
                                                         openingCrawl: $0.openingCrawl)) }
        view.configureFilms(with: contents)
        containerView.addContentView(view)
    }

    func configureVehicles(for view: DetailContainerView) {
        var contents = [VehicleViewContent]()
        viewModel.vehicles?.forEach { contents.append(VehicleViewContent.create(from: $0)) }
        view.configureVehicles(with: contents)
        containerView.addContentView(view)
    }
}
