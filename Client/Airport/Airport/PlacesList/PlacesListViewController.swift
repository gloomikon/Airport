import UIKit
import Alamofire

fileprivate struct PlaceInfo {
    let id: Int
    let planeId: Int
    let name: String
    let booked: Bool

    init(from place: Place, booked: Bool) {
        self.id = place.id
        self.planeId = place.planeId
        self.name = place.name
        self.booked = booked
    }
}

class PlacesListViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    // MARK: - Properties

    private var flight: Flight!
    private var places: [PlaceInfo] = []
    private var tickets: [Ticket] = []
    private let cellId = String(describing: UITableViewCell.self)
    private let segueHandler = SegueHandler()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchPlaces()
    }

    // MARK: - Configure

    func configure(with flight: Flight) {
        self.flight = flight
    }

    // MARK: - Private functions

    private func fetchPlaces() {
        let params: Parameters = [
            "planeId": "\(flight.planeId)"
        ]

        ApiCaller.makeRequest(endPoint: "places", method: .get, params: params, type: [Place].self)
            .zip(ApiCaller.makeRequest(endPoint: "tickets", method: .get, type: [Ticket].self))
            .onSuccess { places, tickets in
                self.places = places.map { place in
                    let booked = tickets.contains { ticket in
                        return ticket.placeId == place.id
                            && ticket.flightId == self.flight.id
                    }
                    return PlaceInfo(from: place, booked: booked)
                }
                self.tickets = tickets
                self.tableView.reloadData()
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        ApiCaller.makeRequest(endPoint: "planes", method: .get, type: [Plane].self)
            .onSuccess { planes in
                let plane = planes.first { $0.id == self.flight.planeId }!
                self.segueHandler.perform(from: self, identifier: "showCompany") { controller in
                    if let controller = controller as? CompanyViewController {
                        controller.configure(with: plane.companyId)
                    }
                }

        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate

extension PlacesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !places[indexPath.row].booked else {
            showAlert(type: .error, message: "Place is already booked")
            return
        }
        
        let params: Parameters = [
            "userId": user.id,
            "placeId": places[indexPath.row].id,
            "flightId": flight.id
        ]

        ApiCaller.makeRequest(endPoint: "tickets", method: .post, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.showAlert(type: .success, message: "Place has been booked") { _ in
                        self.fetchPlaces()
                    }
                }
                else {
                    self.showAlert(type: .error, message: "Something bad happened")
                }
        }
    }
}

// MARK: - UITableViewDataSource

extension PlacesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name + (places[indexPath.row].booked ? " (BOOKED)" : "")
        return cell
    }
}
