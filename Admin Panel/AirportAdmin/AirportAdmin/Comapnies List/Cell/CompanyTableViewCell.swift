import UIKit

class CompanyTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .italicSystemFont(ofSize: 17)
        }
    }

    // MARK: - Configure

    func configure(with company: Company) {
        nameLabel.text = company.name
        descriptionLabel.text = company.description
    }
}
