import UIKit

class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        font = UIFont.systemFont(ofSize: 16,
                                 weight: .bold)
    }
}

class DescriptionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        font = UIFont.systemFont(ofSize: 12,
                                 weight: .regular)
    }
}
