import UIKit
import Alamofire

class SignInViewController: GradientViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var submitButton: UIButton! {
        didSet {
            submitButton.layer.borderColor = UIColor.gray.cgColor
            submitButton.layer.borderWidth = 1
            submitButton.layer.cornerRadius = 10
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func sumbitButtonTapped(_ sender: Any) {
        guard let login = loginTextField.text, !login.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                showAlert(message: "You must fill all the field!")
                return
        }

        let params: Parameters = [
            "login": login,
            "password": password.md5()
        ]

        Alamofire.request("http://localhost:8080/auth", method: .post, parameters: params, encoding: URLEncoding.default)
            .response { response in
                do {
                    let users = try JSONDecoder().decode([User].self, from: response.data!)
                    guard let user = users.first else {
                        DispatchQueue.main.async {
                            self.showAlert(message: "Incorrect username and/or password")
                        }
                        return
                    }
                    DispatchQueue.main.async {

                    }
                }
                catch {
                    self.showAlert(message: "Incorrect username and/or password")
                }
        }
    }
}
