import UIKit

enum AlertType {
    case error
    case success
}

extension UIViewController {
    func showAlert(type: AlertType, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let title: String
        switch type {
        case .error:
            title = "Error"
        case .success:
            title = "Success"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        present(alert, animated: true)
    }
}
