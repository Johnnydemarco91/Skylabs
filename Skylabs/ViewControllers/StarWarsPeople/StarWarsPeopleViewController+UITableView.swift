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
        let emptyView = EmptyView.create(title: "No Data",
                                         description: "There isn't data.")

        switch viewModel.showableList {
        case .generic:
            tableView.backgroundView = viewModel.people.list.isEmpty ? emptyView : nil
            return viewModel.people.list.count
        case .filtered:
            tableView.backgroundView = viewModel.filteredPeople.list.isEmpty ? emptyView : nil
            return viewModel.filteredPeople.list.count
        }
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
