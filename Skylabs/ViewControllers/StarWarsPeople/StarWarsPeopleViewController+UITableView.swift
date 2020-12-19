import UIKit

extension StarWarsPeopleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableCell.self)) as? TableCell else {
            return UITableViewCell()
        }
        tableCell.configure(from: viewModel.showableList == .generic ?
                                viewModel.people.list[indexPath.row] :
                                viewModel.filteredPeople.list[indexPath.row])
        return tableCell
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.showableList == .generic ?
            viewModel.people.list.count :
            viewModel.filteredPeople.list.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        checkforUpdate(with: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetail(for: viewModel.showableList == .generic ?
                    viewModel.people.list[indexPath.row] :
                    viewModel.filteredPeople.list[indexPath.row])
    }
}
