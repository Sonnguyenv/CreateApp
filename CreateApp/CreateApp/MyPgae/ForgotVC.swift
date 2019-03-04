

import UIKit

class ForgotVC: UIViewController {
    
    @IBOutlet weak var textResetPassword: UITextField!
    @IBOutlet weak var resetView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        resetView.layer.borderWidth = 0
        resetView.layer.cornerRadius = 10
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        sender.flash()
        //        MARK: POST Generic ResetPassWord
        postGenericData(urlString: URLString.urlRegister, parameters: ["email": textResetPassword.text]) { (json: ResponseSample) in
            print(json.status)
    
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
