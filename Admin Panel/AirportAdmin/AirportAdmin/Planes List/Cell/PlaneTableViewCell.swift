import UIKit

class PlaneTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }
    @IBOutlet var capacityLabel: UILabel! {
        didSet {
            capacityLabel.font = .italicSystemFont(ofSize: 17)
        }
    }

    // MARK: - Configure

    func configure(with plane: Plane) {
        nameLabel.text = plane.name
        capacityLabel.text = "\(plane.capacity) places"
    }
    
}
