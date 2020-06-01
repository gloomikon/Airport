import UIKit

class FlightsListViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    private var flights: [Flight] = []
    private let cellId = String(describing: FlightTableViewCell.self)
    private let segueHandler = SegueHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FlightTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchFlights()
    }

    // MARK: - Private functions
    private func fetchFlights() {
        ApiCaller.makeRequest(endPoint: "flights", method: .get, type: [Flight].self)
            .onSuccess { flights in
                self.flights = flights
                self.tableView.reloadData()
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate
extension FlightsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueHandler.perform(from: self, identifier: "showPlaces") { controller in
            if let controller = controller as? PlacesListViewController {
                controller.configure(with: self.flights[indexPath.row])
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FlightsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FlightTableViewCell
        cell.configure(with: flights[indexPath.row])
        return cell
    }
}
