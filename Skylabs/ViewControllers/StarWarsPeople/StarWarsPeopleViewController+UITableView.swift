import UIKit

extension StarWarsPeopleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableCell.self)) as? TableCell else {
            return UITableViewCell()
        }
        tableCell.configure(from: viewModel.people[indexPath.row])
        return tableCell
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.people.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        checkforUpdate(with: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = PeopleDetailViewController(viewModel: .init(people: viewModel.people[indexPath.row],
                                                                 films: [],
                                                                 vehicles: []))
        let navVC = UINavigationController.createNavigation(with: detail)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC,
                animated: true)
    }
}
