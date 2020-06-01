import UIKit
import Alamofire
import BrightFutures


class CompaniesViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    // MARK: - Properties

    private var companies: [Company] = []
    private let cellId = String(describing: CompanyTableViewCell.self)
    private let segueHandler = SegueHandler()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CompanyTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchCompanies()
    }

    // MARK: - Private functions

    private func fetchCompanies() {
        let endPoint = "companies"
        let method = HTTPMethod.get
        ApiCaller.makeRequest(endPoint: endPoint, method: method, type: [Company].self)
            .onSuccess { companies in
                self.companies = companies
                self.tableView.reloadData()
        }
        .onFailure { error in
            print(error.localizedDescription)
        }
    }

    @IBAction func viewFlightsButtonTapped(_ sender: Any) {
        segueHandler.perform(from: self, identifier: "showFlights")
    }

    @IBAction func addNewCompanyButtonTapped(_ sender: Any) {
        segueHandler.perform(from: self, identifier: "addNewComapany")
    }

}

// MARK: - UITableViewDelegate

extension CompaniesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueHandler.perform(from: self, identifier: "updateCompany") { controller in
            if let controller = controller as? NewCompanyViewController {
                controller.configure(with: self.companies[indexPath.row])
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension CompaniesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CompanyTableViewCell
        cell.configure(with: companies[indexPath.row])
        return cell
    }
}
