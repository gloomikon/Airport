import UIKit
import Alamofire

class NewFlightViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var nameFromLabel: UILabel! {
        didSet {
            nameFromLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    @IBOutlet var nameFromTextField: UITextField! {
           didSet {
            nameFromTextField.placeholder = "Departure name"
           }
       }

    @IBOutlet var nameToLabel: UILabel! {
           didSet {
            nameToLabel.font = .systemFont(ofSize: 17, weight: .semibold)
           }
       }

    @IBOutlet var nameToTextField: UITextField! {
           didSet {
            nameToTextField.placeholder = "Arrival name"
           }
       }

    @IBOutlet var dateFromLabel: UILabel! {
        didSet {
            dateFromLabel.font = .italicSystemFont(ofSize: 17)
        }
    }

    @IBOutlet var dateFromTextField: UITextField! {
           didSet {
            dateFromTextField.placeholder = "Departure date"
           }
       }

    @IBOutlet var dateToLabel: UILabel! {
        didSet {
            dateToLabel.font = .italicSystemFont(ofSize: 17)
        }
    }

    @IBOutlet var dateToTextField: UITextField! {
           didSet {
            dateToTextField.placeholder = "Arrival date"
           }
       }

    @IBOutlet var submitButton: UIButton! {
        didSet {
            submitButton.layer.borderWidth = 2
            submitButton.layer.borderColor = UIColor.lightGray.cgColor
            submitButton.layer.cornerRadius = 10
            submitButton.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBOutlet var deleteButton: UIButton! {
        didSet {
            deleteButton.layer.borderWidth = 2
            deleteButton.layer.borderColor = UIColor.lightGray.cgColor
            deleteButton.layer.cornerRadius = 10
            deleteButton.setTitleColor(.black, for: .normal)
        }
    }

    // MARK: - Properties

    private var plane: Plane!
    private var flight: Flight!
    private var state: State = .adding
    private var dateFrom: Date?
    private var dateTo: Date?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let fromDatePicker = UIDatePicker()
        let toDatePicker = UIDatePicker()

        fromDatePicker.datePickerMode = .dateAndTime
        toDatePicker.datePickerMode = .dateAndTime

        fromDatePicker.addTarget(self, action: #selector(fromDatePickerChangedValue(sender:)), for: .valueChanged)
        toDatePicker.addTarget(self, action: #selector(toDatePickerChangedValue(sender:)), for: .valueChanged)

        dateFromTextField.inputView = fromDatePicker
        dateToTextField.inputView = toDatePicker

        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        switch state {
        case .adding:
            setUIForAdding()
        case .updating:
            setUIForUpdating()
        }
    }

    // MARK: - Configure

    func configure(with plane: Plane) {
        self.plane = plane
        state = .adding
    }

    func configure(with flight: Flight) {
        self.flight = flight
        state = .updating
    }

    // MARK: - Private functions

    @objc private func endEditing() {
        view.endEditing(true)
    }

    private func setUIForAdding() {
        [nameToLabel, nameFromLabel, dateToLabel, dateFromLabel, deleteButton].forEach {
            $0?.isHidden = true
        }
    }

    private func setUIForUpdating() {
        [nameFromTextField, nameToTextField, dateFromTextField, dateToTextField, submitButton].forEach {
            $0?.isHidden = true
        }

        nameFromLabel.text = flight.nameFrom
        nameToLabel.text = flight.nameTo
        dateFromLabel.text = flight.dateFrom
        dateToLabel.text = flight.dateTo
    }

    @objc private func fromDatePickerChangedValue(sender: UIDatePicker) {
        let formatter = DateFormatter()

        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        dateFrom = sender.date

        dateFromTextField.text = formatter.string(from: sender.date)
    }

    @objc private func toDatePickerChangedValue(sender: UIDatePicker) {
        let formatter = DateFormatter()

        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        dateTo = sender.date

        dateToTextField.text = formatter.string(from: sender.date)
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let dateFrom = dateFrom,
        let dateTo = dateTo,
            dateTo > dateFrom,
            dateFrom > Date(),
            let nameFrom = nameFromTextField.text, !nameFrom.isEmpty,
            let nameTo = nameToTextField.text, !nameTo.isEmpty else {
                showAlert(type: .error, message: "Incorrect data")
                return
        }

        let params: Parameters = [
            "name_from": nameFrom,
            "name_to": nameTo,
            "date_from": dateFromTextField.text!,
            "date_to": dateToTextField.text!,
            "planeId": "\(plane.id)"
        ]

        ApiCaller.makeResponse(endPoint: "flights", method: .post, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.showAlert(type: .success, message: "Flight has been created") { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                else {
                    self.showAlert(type: .error, message: "Something bad happened")
                }
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        let params: Parameters = [
            "id": "\(flight.id)"
        ]

        ApiCaller.makeResponse(endPoint: "flights", method: .delete, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.showAlert(type: .success, message: "Flight has been deleted") { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
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
