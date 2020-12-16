import UIKit

extension StarWarsPeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.people.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let collectionCell = collectionView
                .dequeueReusableCell(withReuseIdentifier: String(describing: CollectionCell.self),
                                     for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        collectionCell.configure(from: viewModel.people[indexPath.row])
        return collectionCell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        checkforUpdate(with: indexPath)
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
