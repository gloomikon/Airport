import UIKit
import Alamofire

struct TicketInfo {
    let id: Int
    let nameFrom: String
    let nameTo: String
    let dateFrom: String
    let dateTo: String

    init(flight: Flight, ticket: Ticket) {
        self.id = ticket.id
        self.nameFrom = flight.nameFrom
        self.nameTo = flight.nameTo
        self.dateFrom = flight.dateFrom
        self.dateTo = flight.dateTo
    }
}

class TicketsListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    // MARK: - Properties

    private let cellId = String(describing: FlightTableViewCell.self)
    private var tickets: [TicketInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FlightTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchTickets()
    }

    private func fetchTickets() {
        ApiCaller.makeRequest(endPoint: "tickets", method: .get, type: [Ticket].self)
            .zip(ApiCaller.makeRequest(endPoint: "flights", method: .get, type: [Flight].self))
            .onSuccess { tickets, flights in
                self.tickets = tickets.filter { $0.userId == user.id }
                .map { ticket in
                    let flight = flights.first { $0.id == ticket.flightId }!
                    return TicketInfo(flight: flight, ticket: ticket)
                }
                self.tableView.reloadData()
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate

extension TicketsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let params: Parameters = [
            "id": "\(tickets[indexPath.row].id)"
        ]

        ApiCaller.makeRequest(endPoint: "tickets", method: .delete, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.fetchTickets()
                }
                else {
                    self.showAlert(type: .error, message: "Something bad happened")
                }
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDataSource

extension TicketsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FlightTableViewCell
        cell.configure(with: tickets[indexPath.row])
        return cell
    }
}
