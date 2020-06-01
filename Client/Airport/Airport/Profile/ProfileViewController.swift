import UIKit
import Alamofire

class ProfileViewController: GradientViewController {

    // MARK: - IBOutlets

    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    @IBOutlet var nameTextField: UITextField! {
        didSet {
            nameTextField.placeholder = "Name"
        }
    }

    @IBOutlet var surnameLabel: UILabel! {
        didSet {
            surnameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    @IBOutlet var surnameTextField: UITextField! {
        didSet {
            surnameTextField.placeholder = "Surname"
        }
    }

    @IBOutlet var loginLabel: UILabel! {
        didSet {
            loginLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        }
    }

    @IBOutlet var loginTextField: UITextField! {
        didSet {
            loginTextField.placeholder = "Login"
        }
    }

    @IBOutlet var passportLabel: UILabel! {
        didSet {
            passportLabel.font = .italicSystemFont(ofSize: 17)
        }
    }

    @IBOutlet var passportTextField: UITextField! {
        didSet {
            passportTextField.placeholder = "Passport"
        }
    }

    @IBOutlet var changeProfileButton: UIButton! {
        didSet {
            changeProfileButton.layer.borderColor = UIColor.black.cgColor
            changeProfileButton.layer.borderWidth = 2
            changeProfileButton.layer.cornerRadius = 10
            changeProfileButton.setTitleColor(.black, for: .normal)
        }
    }

    @IBOutlet var doneButton: UIButton! {
        didSet {
            doneButton.layer.borderColor = UIColor.black.cgColor
            doneButton.layer.borderWidth = 2
            doneButton.layer.cornerRadius = 10
            doneButton.setTitleColor(.black, for: .normal)
        }
    }

    @IBOutlet var cancelButton: UIButton! {
        didSet {
            cancelButton.layer.borderColor = UIColor.systemRed.cgColor
            cancelButton.layer.borderWidth = 2
            cancelButton.layer.cornerRadius = 10
            cancelButton.setTitleColor(.systemRed, for: .normal)
        }
    }

    // MARK: -  Properties

    private var state: State = .adding {
        didSet {
            switch state {
            case .adding:
                setUIForDisplay()
            case .updating:
                setUIForUpdation()
            }
        }
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUIForDisplay()
    }

    // MARK: - Private functions

    private func setUIForDisplay() {
        [nameTextField, surnameTextField, passportTextField, loginTextField, doneButton, cancelButton].forEach {
            $0?.isHidden = true
        }

        [nameLabel, surnameLabel, passportLabel, loginLabel, changeProfileButton].forEach {
            $0?.isHidden = false
        }

        nameLabel.text = user.name
        surnameLabel.text = user.surname
        loginLabel.text = user.login
        passportLabel.text = user.passport
    }

    private func setUIForUpdation() {
        [nameTextField, surnameTextField, passportTextField, loginTextField, doneButton, cancelButton].forEach {
            $0?.isHidden = false
        }

        [nameLabel, surnameLabel, passportLabel, loginLabel, changeProfileButton].forEach {
            $0?.isHidden = true
        }
    }

    @IBAction func changeProfileButtonTapped(_ sender: Any) {
        state = .updating
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
            let surname = surnameTextField.text, !surname.isEmpty,
            let login = loginTextField.text, !login.isEmpty,
            let passport = passportTextField.text, !passport.isEmpty else {
                showAlert(type: .error, message: "Fields can not be empty")
                return
        }

        let params: Parameters = [
            "id": "\(user.id)",
            "name": name,
            "surname": surname,
            "passport": passport,
            "password": user.password,
            "login": login
        ]

        ApiCaller.makeRequest(endPoint: "auth", method: .put, params: params, type: [User].self)
            .onSuccess { users in
                guard let parsedUser = users.first else {
                    self.showAlert(type: .error, message: "Username is already taken")
                    return
                }

                user = parsedUser
                self.showAlert(type: .success, message: "Data has been updated") { _ in
                    self.state = .adding
                }
        }
        .onFailure { error in
            self.showAlert(type: .error, message: error.localizedDescription)
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        state = .adding
    }

    @IBAction func logOutButtonTapped(_ sender: Any) {
        user = nil
        performSegue(withIdentifier: "logOut", sender: nil)
    }
}
