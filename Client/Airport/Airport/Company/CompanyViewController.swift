import UIKit
import Alamofire

class CompanyViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet var ratingLabel: UILabel! {
           didSet {
            ratingLabel.font = .italicSystemFont(ofSize: 17)
           }
       }

    // MARK: - Properties

    private var company: Company!
    private var companyId: Int!
    private var reviews: [Review] = []
    private let segueHandler = SegueHandler()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchCompany()
    }

    // MARK: - Configure

    func configure(with companyId: Int) {
        self.companyId = companyId
    }


    private func fetchCompany() {
        ApiCaller.makeRequest(endPoint: "companies", method: .get, type: [Company].self)
            .onSuccess { companies in
                self.company = companies.first { $0.id == self.companyId}!

                let params: Parameters = [
                    "companyId": self.company.id

                ]
                ApiCaller.makeRequest(endPoint: "reviews", method: .get, params: params, type: [Review].self)
                    .onSuccess { reviews in
                        self.reviews = reviews
                        self.displayInfo()
                }
                .onFailure { error in
                    self.showAlert(type: .error, message: error.localizedDescription)
                }
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }

    private func displayInfo() {
        nameLabel.text = company.name
        descriptionLabel.text = company.description
        let rating: Double? = reviews.count > 0 ? Double(reviews.reduce(0) { $0 + $1.rating }) / Double(reviews.count)   : nil
        ratingLabel.text = rating != nil ? String(format: "%.2f", rating!) : "No reviews for this company"
    }

    @IBAction func showReviewsButtonTapped(_ sender: Any) {
        segueHandler.perform(from: self, identifier: "showReviews") { controller in
            if let controller = controller as? ReviewsListViewController {
                controller.configure(with: self.company)
            }
        }
    }
}
