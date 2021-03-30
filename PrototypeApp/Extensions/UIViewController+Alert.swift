
import UIKit

enum AlertAction: String {
    case Ok
    case Cancel
}

typealias AlertHandler = (_ action: AlertAction) -> Void

extension UIViewController {
    
    func presentAlert(title: String, message : String) {
        presentAlert(title: title, message: message, actions: .Ok, handler: nil)
    }
    
    func presentAlert(title: String, message: String, actions: AlertAction..., handler: AlertHandler?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for arg in actions {
            let action = UIAlertAction(title: arg.rawValue, style: .default, handler: { (action) in
                handler?(arg)
            })
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
