import UIKit

class StarWarsPeopleViewController: UIViewController {
    let viewModel: StarWarsPeopleViewModel

    let searchController = UISearchController(searchResultsController: nil)
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(TableCell.self,
                           forCellReuseIdentifier: String(describing: TableCell.self))
        return tableView
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(CollectionCell.self,
                                forCellWithReuseIdentifier: String(describing: CollectionCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    init(viewModel: StarWarsPeopleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil,
                   bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        extendedLayoutIncludesOpaqueBars = true
        title = "Starwars People"
        view.backgroundColor = .white
        setupUI()
        updateData()
        setupNavigation()
        prepareSearch()
    }

    private func setupNavigation() {
        let button = UIButton()
        button.setImage(UIImage(named: "sort"),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(filter(_:)),
                         for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }

    private func setupUI() {
        switch viewModel.layout {
        case .list:
            view.addSubview(tableView)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])

            tableView.delegate = self
            tableView.dataSource = self
        case .collection:
            view.addSubview(collectionView)
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    private func prepareSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.backgroundColor = .clear
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

// MARK: - Data

extension StarWarsPeopleViewController {
    private func updateData(name: String? = nil) {
        guard let name = name else {
            showLoading()
            viewModel.updatePeople() { result in
                self.hideLoading()
                switch result {
                case .success:
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                case .failure(let error):
                    self.showEmptyView(with: error.description)
                }
            }
            return
        }
        showLoading()
        viewModel.searchPeople(name: name) { result in
            self.hideLoading()
            switch result {
            case .success:
                self.tableView.reloadData()
                self.collectionView.reloadData()
            case .failure(let error):
                self.showEmptyView(with: error.description)
            }
        }
    }

    func checkforUpdate(with indexPath: IndexPath) {
        guard needUpdatePeople(from: indexPath.row) ||
                needUpdateFilteredPeople(from: indexPath.row) else {
            return
        }
        updateData(name: viewModel.showableList == .filtered ? searchController.searchBar.text : nil)
    }

    private func needUpdatePeople(from row: Int) -> Bool {
        viewModel.showableList == .generic &&
            row == viewModel.people.list.count - 1 &&
            viewModel.people.next != nil
    }

    private func needUpdateFilteredPeople(from row: Int) -> Bool {
        viewModel.showableList == .filtered &&
            row == viewModel.filteredPeople.list.count - 1 &&
            viewModel.filteredPeople.next != nil
    }

    private func showEmptyView(with error: String) {
        let emptyView = EmptyView.create(title: "Error found",
                                         description: error)
        self.tableView.backgroundView = emptyView
        self.collectionView.backgroundView = emptyView
    }
}

extension StarWarsPeopleViewController {
    func showDetail(for person: Person) {
        let detail = PersonDetailViewController(viewModel: .init(person: person))
        let navVC = UINavigationController.createNavigation(with: detail)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC,
                     animated: true)
    }

    @objc
    func filter(_ sender: UIButton) {
        guard viewModel.alphabeticalOrder != nil else {
            viewModel.alphabeticalOrder = .ascending
            rotate(sender)
            order()
            return
        }
        viewModel.alphabeticalOrder = viewModel.alphabeticalOrder == .ascending ?
            .descending :
            .ascending
        rotate(sender)
        order()
    }

    private func order() {
        viewModel.order()
        tableView.reloadData()
        collectionView.reloadData()
    }

    private func rotate(_ button: UIButton) {
        guard viewModel.alphabeticalOrder == .descending else {
            let radians = CGFloat(180 * Double.pi / 180)
            button.transform3D =
                CATransform3DMakeRotation(radians, 0, 1, 0)
            return
        }
        button.transform3D =
            CATransform3DMakeRotation(0, 0, 1.0, 0)
    }
}

extension StarWarsPeopleViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if
            let text = searchController.searchBar.text,
            text.count > 1 {
            viewModel.filteredPeople = StarWarsPeople()
            viewModel.showableList = .filtered
            updateData(name: text)
        } else {
            viewModel.showableList = .generic
            guard !viewModel.filteredPeople.list.isEmpty else {
                return
            }
            viewModel.filteredPeople = StarWarsPeople()
            updateData()
        }
    }
}
