import UIKit
import Alamofire

class NewCompanyViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet var nameTextField: UITextField! {
        didSet {
            nameTextField.placeholder = "Company Name"
            if case State.updating = state {
                nameTextField.text = company?.name
            }
        }
    }

    @IBOutlet var descriptionTextField: UITextField! {
        didSet {
            descriptionTextField.placeholder = "Company Description"
            if case State.updating = state {
                descriptionTextField.text = company?.description
            }
        }
    }

    @IBOutlet var submitButton: UIButton! {
        didSet {
            submitButton.layer.borderColor = UIColor.lightGray.cgColor
            submitButton.layer.borderWidth = 1
            submitButton.layer.cornerRadius = 5
            submitButton.setTitleColor(.black, for: .normal)
        }
    }

    @IBOutlet var deleteButton: UIButton! {
        didSet {
            deleteButton.isHidden = state == .adding
            deleteButton.layer.borderColor = UIColor.lightGray.cgColor
            deleteButton.layer.borderWidth = 1
            deleteButton.layer.cornerRadius = 5
            deleteButton.setTitleColor(.black, for: .normal)
        }
    }

    // MARK: - Properties

    private var state: State = .adding
    private var company: Company?
    private let segueHandler = SegueHandler()

    // MARK: - Configure

    func configure(with company: Company) {
        self.state = .updating
        self.company = company

        let viewPlanesButton = UIBarButtonItem(title: "View planes", style: .plain, target: self, action: #selector(viewPlanesButtonTapped))
        navigationItem.setRightBarButtonItems([viewPlanesButton], animated: false)
    }

    // MARK: - Private functions

    private func postNewCompany(name: String, description: String) {
        let params: Parameters = [
            "name": name,
            "description": description
        ]

        ApiCaller.makeResponse(endPoint: "companies", method: .post, params: params, type: Bool.self)
            .onSuccess { result in
                if result {
                    self.showAlert(type: .success, message: "Company has been created") { _ in
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

    private func putCompany(id: Int, name: String, description: String) {
        let params: Parameters = [
            "id": "\(id)",
            "name": name,
            "description": description
        ]

        ApiCaller.makeResponse(endPoint: "companies", method: .put, params: params, type: Bool.self)
            .onSuccess { result in
                self.showAlert(type: .success, message: "Company has been updated") { _ in
                    self.navigationController?.popViewController(animated: true)
                }
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }

    private func deleteCompany(id: Int) {
        let params: Parameters = [
            "id": "\(id)"
        ]

        ApiCaller.makeResponse(endPoint: "companies", method: .delete, params: params, type: Bool.self)
            .onSuccess { result in
                self.showAlert(type: .success, message: "Company has been deleted") { _ in
                    self.navigationController?.popViewController(animated: true)
                }
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
            let description = descriptionTextField.text, !description.isEmpty else {
                return
        }
        switch state {
        case .adding:
            postNewCompany(name: name, description: description)
        case .updating:
            guard let company = company else {
                return
            }
            putCompany(id: company.id, name: name, description: description)
        }
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let copmany = company else {
            return
        }

        deleteCompany(id: copmany.id)
    }

    @objc private func viewPlanesButtonTapped() {
        segueHandler.perform(from: self, identifier: "showPlanes") { controller in
            if let controller = controller as? PlanesListViewController,
                let company = self.company {
                controller.configure(with: company)
            }
        }
    }
}
