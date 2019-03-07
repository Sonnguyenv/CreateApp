

import UIKit

class ForgotVC: UIViewController {
    
    @IBOutlet weak var textResetPassword: UITextField!
    @IBOutlet weak var resetView: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.isHidden = true
        resetView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        resetView.layer.borderWidth = 0
        resetView.layer.cornerRadius = 10
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        sender.flash()
        //        MARK: POST Generic ResetPassWord
        self.activity.isHidden = false
        self.view.alpha = 0.8
        self.activity.startAnimating()
        postGenericData(urlString: URLString.urlRegister, parameters: ["email": textResetPassword.text]) { (json: ResponseSample) in
            print(json.status)
            DispatchQueue.main.async {
                self.activity.isHidden = true
                self.view.alpha = 1.0
                self.activity.stopAnimating()
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
