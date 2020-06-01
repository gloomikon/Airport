import UIKit
import Alamofire

class SignInViewController: GradientViewController {

    // MARK: - IBOutlets

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var submitButton: UIButton! {
        didSet {
            submitButton.layer.borderColor = UIColor.gray.cgColor
            submitButton.layer.borderWidth = 1
            submitButton.layer.cornerRadius = 10
        }
    }

    // MARK: - Properties

    private let segueHandler = SegueHandler()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Private actions

    @IBAction func sumbitButtonTapped(_ sender: Any) {
        guard let login = loginTextField.text, !login.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                showAlert(type: .error, message: "Fields can not be empty")
                return
        }

        let params: Parameters = [
            "login": login,
            "password": password.md5()
        ]

        ApiCaller.makeRequest(endPoint: "auth", method: .get, params: params, type: [User].self)
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

    @IBAction func unwindToStart(segue:UIStoryboardSegue) { }
}
