import Kingfisher

extension UIImageView {
    func setPersonAvatar(from id: Int?) {
        guard
            let id = id,
            let url = URL(string: "http://mobile.aws.skylabs.it/mobileassignments/swapi/\(id).png")
        else {

            return
        }
        kf.setImage(with: ImageResource(downloadURL: url),
                    placeholder: UIImage(named: "placeholderImage"))

    }
}
