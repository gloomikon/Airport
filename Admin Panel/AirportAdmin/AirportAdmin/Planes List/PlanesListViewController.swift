import UIKit
import Alamofire

class PlanesListViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    // MARK: - Properties

    private var company: Company!
    private var planes: [Plane] = []
    private let cellId = String(describing: PlaneTableViewCell.self)
    private let segueHandler = SegueHandler()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let addNewPlane = UIBarButtonItem(title: "Add new plane", style: .plain, target: self, action: #selector(addNewPlaneButtonTapped))
        navigationItem.setRightBarButtonItems([addNewPlane], animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.register(UINib(nibName: "PlaneTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        fetchPlanes()
    }

    // MARK: - Configure

    func configure(with company: Company) {
        self.company = company
    }

    // MARK: - Private functions

    private func fetchPlanes() {
        let params: Parameters = [
            "companyId": "\(company.id)"
        ]

        ApiCaller.makeResponse(endPoint: "planes", method: .get, params: params, type: [Plane].self)
            .onSuccess { planes in
                self.planes = planes
                self.tableView.reloadData()
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription) { _ in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    @objc private func addNewPlaneButtonTapped() {
        segueHandler.perform(from: self, identifier: "addNewPlane") { controller in
            if let controller = controller as? NewPlaneViewController {
                controller.configure(company: self.company)
            }
        }
    }
}

extension PlanesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueHandler.perform(from: self, identifier: "updatePlane") { controller in
            if let controller = controller as? NewPlaneViewController {
                controller.configure(plane: self.planes[indexPath.row], company: self.company)
            }
        }
    }
}

extension PlanesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlaneTableViewCell
        cell.configure(with: planes[indexPath.row])
        return cell
    }
}
