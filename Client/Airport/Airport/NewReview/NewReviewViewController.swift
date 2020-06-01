import UIKit
import Alamofire

class NewReviewViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var reviewTextTextLabel: UITextField! {
        didSet {
            reviewTextTextLabel.placeholder = "Review text"
        }
    }

    @IBOutlet var ratingLabel: UILabel! {
        didSet {
            ratingLabel.text = "3"
        }
    }

    @IBOutlet var stepper: UIStepper! {
        didSet {
            stepper.value = 3
            stepper.stepValue = 1
            stepper.minimumValue = 1
            stepper.maximumValue = 5
        }
    }

    @IBOutlet var confirmButton: UIButton! {
        didSet {
            confirmButton.layer.borderColor = UIColor.lightGray.cgColor
            confirmButton.layer.borderWidth = 2
            confirmButton.layer.cornerRadius = 10
            confirmButton.setTitleColor(.black, for: .normal)
        }
    }

    @IBOutlet var deleteButton: UIButton! {
        didSet {
            deleteButton.layer.borderColor = UIColor.lightGray.cgColor
            deleteButton.layer.borderWidth = 2
            deleteButton.layer.cornerRadius = 10
            deleteButton.setTitleColor(.black, for: .normal)
        }
    }

    // MARK: - Properties

    private var company: Company!
    private var review: Review!

    private var state: State = .adding

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        switch state {
        case.adding:
            setUIForAdding()
        case .updating:
            setUIForUpdating()
        }
    }

    // MARK: - Configure
    
    func configure(with review: Review) {
        self.review = review
        state = .updating
    }

    func configure(with company: Company) {
        self.company = company
        state = .adding
    }

    // MARK: - Private functions

    private func setUIForAdding() {
        deleteButton.isHidden = true
    }

    private func setUIForUpdating() {
        deleteButton.isHidden = false

        reviewTextTextLabel.text = review.text
        stepper.value = Double(review.rating)
        ratingLabel.text = "\(review.rating)"
    }

    @IBAction func stepperChangedValue(_ sender: Any) {
        ratingLabel.text = "\(Int(stepper.value))"
    }

    @IBAction func confirmButtonTapped(_ sender: Any) {
        switch state {
        case .adding:
            addCompany()
        case .updating:
            updateCompany()
        }
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteCompany()
    }

    private func addCompany() {
        guard let text = reviewTextTextLabel.text, !text.isEmpty else {
            showAlert(type: .error, message: "Fields can not be empty")
            return
        }

        let params: Parameters = [
            "text": text,
            "rating": Int(stepper.value),
            "userId": user.id,
            "companyId": company.id
        ]

        ApiCaller.makeRequest(endPoint: "reviews", method: .post, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.showAlert(type: .success, message: "Review has been added") { _ in
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

    private func updateCompany() {
        guard let text = reviewTextTextLabel.text, !text.isEmpty else {
            showAlert(type: .error, message: "Fields can not be empty")
            return
        }

        let params: Parameters = [
            "id": review.id,
            "text": text,
            "rating": Int(stepper.value),
            "userId": user.id,
            "companyId": review.companyId
        ]

        ApiCaller.makeRequest(endPoint: "reviews", method: .put, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.showAlert(type: .success, message: "Review has been updated") { _ in
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

    private func deleteCompany() {
        let params: Parameters = [
            "id": review.id
        ]

        ApiCaller.makeRequest(endPoint: "reviews", method: .delete, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.showAlert(type: .success, message: "Review has been deleted") { _ in
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
