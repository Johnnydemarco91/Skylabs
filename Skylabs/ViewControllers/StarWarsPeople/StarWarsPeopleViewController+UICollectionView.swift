import UIKit

extension StarWarsPeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emptyView = EmptyView.create(title: "No Data",
                                         description: "There isn't data.")

        switch viewModel.showableList {
        case .generic:
            collectionView.backgroundView = viewModel.people.list.isEmpty ? emptyView : nil
            return viewModel.people.list.count
        case .filtered:
            collectionView.backgroundView = viewModel.filteredPeople.list.isEmpty ? emptyView : nil
            return viewModel.filteredPeople.list.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let collectionCell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: CollectionCell.self),
                                     for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        collectionCell.configure(from: viewModel.showableList == .generic ?
                                    viewModel.people.list[indexPath.row] :
                                    viewModel.filteredPeople.list[indexPath.row])
        return collectionCell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        checkforUpdate(with: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetail(for: viewModel.showableList == .generic ?
                    viewModel.people.list[indexPath.row] :
                    viewModel.filteredPeople.list[indexPath.row])
    }

}

extension StarWarsPeopleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let widthPerItem = (collectionView.frame.size.width - 16 * 3) / 2
        return CGSize(width: widthPerItem, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16,
              left: 16,
              bottom: 16,
              right: 16)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
