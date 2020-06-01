import UIKit
import Alamofire

class ReviewsListViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    // MARK: - Properties

    private var company: Company!
    private var reviews: [Review] = []
    private let cellId = String(describing: ReviewTableViewCell.self)
    private let segueHandler = SegueHandler()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchReviews()
    }

    // MARK: - Configure

    func configure(with company: Company) {
        self.company = company
    }

    // MARK: - Private functions

    private func fetchReviews() {
        let params: Parameters = [
            "companyId": company.id
        ]

        ApiCaller.makeRequest(endPoint: "reviews", method: .get, params: params, type: [Review].self)
            .onSuccess { reviews in
                self.reviews = reviews
                self.tableView.reloadData()
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }

    @IBAction func addReviewButtonTapped(_ sender: Any) {
        segueHandler.perform(from: self, identifier: "addNewReview") { controller in
            if let controller = controller as? NewReviewViewController {
                controller.configure(with: self.company)
            }
        }
    }
}

extension ReviewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard reviews[indexPath.row].userId == user.id else {
            return
        }

        segueHandler.perform(from: self, identifier: "updateReview") { controller in
            if let controller = controller as? NewReviewViewController {
                controller.configure(with: self.reviews[indexPath.row])
            }
        }
    }
}

extension ReviewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReviewTableViewCell
        cell.configure(with: reviews[indexPath.row])
        return cell
    }
}
