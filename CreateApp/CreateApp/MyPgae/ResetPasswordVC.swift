

import UIKit

class ResetPasswordVC: UIViewController {
    @IBOutlet weak var textResetPassword: UITextField!
    @IBOutlet weak var resetView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        resetView.layer.borderWidth = 5
        resetView.layer.cornerRadius = 10
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        sender.flash()
        //        MARK: POST Generic ResetPassWord
        postGenericData(urlString: URLString.urlRegister, parameters: ["email": textResetPassword.text]) { (json: ResponseSample) in
            print(json.status)
        }
    }
}
