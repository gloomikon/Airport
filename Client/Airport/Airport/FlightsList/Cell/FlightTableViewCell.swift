import UIKit

class FlightTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet var nameFromLabel: UILabel! {
        didSet {
            nameFromLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    @IBOutlet var nameToLabel: UILabel! {
        didSet {
            nameToLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    @IBOutlet var dateFromLabel: UILabel! {
        didSet {
            dateFromLabel.font = .italicSystemFont(ofSize: 17)
        }
    }

    @IBOutlet var dateToLabel: UILabel! {
        didSet {
            dateToLabel.font = .italicSystemFont(ofSize: 17)
        }
    }

    // MARK: - Configure

    func configure(with flight: Flight) {
        nameFromLabel.text = flight.nameFrom
        nameToLabel.text = flight.nameTo
        dateFromLabel.text = flight.dateFrom
        dateToLabel.text = flight.dateTo
    }

    func configure(with ticketInfo: TicketInfo) {
        nameFromLabel.text = ticketInfo.nameFrom
        nameToLabel.text = ticketInfo.nameTo
        dateFromLabel.text = ticketInfo.dateFrom
        dateToLabel.text = ticketInfo.dateTo
    }
}
