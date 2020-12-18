import UIKit

class PeopleDetailViewController: UIViewController {
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

        title = viewModel.people.name
    }
}
