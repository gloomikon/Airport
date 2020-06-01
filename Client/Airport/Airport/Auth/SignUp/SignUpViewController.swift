import UIKit
import Alamofire

class SignUpViewController: GradientViewController {

    // MARK: - IBOutlets

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passportNumberTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var submitButton: UIButton! {
        didSet {
            submitButton.layer.borderColor = UIColor.gray.cgColor
            submitButton.layer.borderWidth = 1
            submitButton.layer.cornerRadius = 10
        }
    }

    // Properties

    private let segueHandler = SegueHandler()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Private functions

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let login = loginTextField.text, !login.isEmpty,
            let passportNumber = passportNumberTextField.text, !passportNumber.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                showAlert(type: .error, message: "You must fill all the field!")
                return
        }

        let params: Parameters = [
            "name": firstName,
            "surname": lastName,
            "login": login,
            "passport": passportNumber,
            "password": password.md5()
        ]

        ApiCaller.makeRequest(endPoint: "auth", method: .post, params: params, type: [User].self)
            .onSuccess { users in
                guard let parsedUser = users.first else {
                    self.showAlert(type: .error, message: "Incorrect username and / or password")
                    return
                }

                user = parsedUser
                self.tabBarController?.tabBar.isHidden = true
                self.segueHandler.perform(from: self, identifier: "navigateToMenu")
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }
}
