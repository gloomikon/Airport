import UIKit
import Alamofire

class NewPlaneViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    @IBOutlet var nameTextField: UITextField! {
        didSet {
            nameTextField.placeholder = "Plane name"
        }
    }

    @IBOutlet var capacityLabel: UILabel! {
        didSet {
            capacityLabel.font = .italicSystemFont(ofSize: 17)
        }
    }

    @IBOutlet var stepper: UIStepper! {
        didSet {
            stepper.value = 20
            stepper.minimumValue = 20
            stepper.maximumValue = 120
            stepper.stepValue = 5
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

    private var plane: Plane?
    private var company: Company!
    private var state: State = .adding
    private let segueHandler = SegueHandler()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
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

    func configure(plane: Plane? = nil, company: Company) {
        self.plane = plane
        self.company = company
        state = self.plane == nil ? .adding : .updating
    }

    // MARK: - Private functions

    private func setUIForAdding() {
        nameLabel.isHidden = true
        deleteButton.isHidden = true

        capacityLabel.text = "\(Int(stepper.value)) places"
    }

    private func setUIForUpdating() {
        nameTextField.isHidden = true
        stepper.isHidden = true
        submitButton.isHidden = true

        nameLabel.text = plane?.name
        capacityLabel.text = "\(plane!.capacity) places"

        let addNewFlightButton = UIBarButtonItem(title: "Add new flight", style: .plain, target: self, action: #selector(addNewFlightButtonTapped))

        navigationItem.setRightBarButtonItems([addNewFlightButton], animated: false)
    }
    
    @IBAction func stepperChangedValue(_ sender: Any) {
        capacityLabel.text = "\(Int(stepper.value)) places"
    }

    @objc private func addNewFlightButtonTapped() {
        segueHandler.perform(from: self, identifier: "addNewFlight") { controller in
            if let controller = controller as? NewFlightViewController {
                controller.configure(with: self.plane!)
            }
        }
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(type: .error, message: "Fields can not be empty!")
            return
        }

        let params: Parameters = [
            "name": name,
            "capacity": "\(Int(stepper.value))",
            "companyId": "\(company.id)"
        ]

        ApiCaller.makeResponse(endPoint: "planes", method: .post, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.showAlert(type: .success, message: "New plane has been added") { (_) in
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
            "id": "\(plane!.id)"
        ]

        ApiCaller.makeResponse(endPoint: "planes", method: .delete, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.showAlert(type: .success, message: "Plane has been deleted") { (_) in
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
