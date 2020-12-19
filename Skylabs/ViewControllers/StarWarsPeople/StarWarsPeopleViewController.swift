import UIKit

class StarWarsPeopleViewController: UIViewController {
    let viewModel: StarWarsPeopleViewModel

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

        title = "Starwars People"
        view.backgroundColor = .white
        setupUI()
        updateData()
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

    func updateData() {
        showLoading()
        viewModel.updatePeople() { result in
            self.hideLoading()
            switch result {
            case .success:
                self.tableView.reloadData()
                self.collectionView.reloadData()
            case .failure:
                #warning("show error")
            }
        }
    }

    func checkforUpdate(with indexPath: IndexPath) {
        guard
            indexPath.row == viewModel.people.count - 1,
            viewModel.next != nil
        else {
            return
        }
        updateData()
    }
}
