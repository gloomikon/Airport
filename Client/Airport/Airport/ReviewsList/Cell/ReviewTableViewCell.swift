import UIKit

class ReviewTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet var authorLabel: UILabel! {
        didSet {
            authorLabel.isHidden = true
            authorLabel.font = .systemFont(ofSize: 17, weight: .bold)
        }
    }

    @IBOutlet var reviewTextLabel: UILabel! {
        didSet {
            reviewTextLabel.font = .italicSystemFont(ofSize: 17)
        }
    }

    @IBOutlet var ratingLabel: UILabel! {
        didSet {
            ratingLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    func configure(with review: Review) {
        authorLabel.isHidden = !(review.userId == user.id)
        authorLabel.text = "(me)"
        reviewTextLabel.text = review.text
        ratingLabel.text = "\(review.rating) \\ 5"
    }
}
