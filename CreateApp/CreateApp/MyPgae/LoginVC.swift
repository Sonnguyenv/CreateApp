
import UIKit



class LoginVC: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var loginView: UIButton!
//    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var forgotButton: UIButton!
    
    let underLine : [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3176470588, green: 0.3725490196, blue: 0.3960784314, alpha: 1),
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
    
    let keyChain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()
        let attributeString = NSMutableAttributedString(string: "Forgot password?",
                                                        attributes: underLine)
        forgotButton.setAttributedTitle(attributeString, for: .normal)
        
        loginView.layer.borderColor  = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loginView.layer.borderWidth  = 0
        loginView.layer.cornerRadius = 10
        textEmail.text = "dreamsonss@gmail.com"
        textPassword.text = "NmpXvfq1"
    }
    
    @IBAction func login(_ sender: UIButton) {
        sender.pulsate()
        // MARK: POST Generic Login
        postGenericData(urlString: URLString.urlLogin, parameters: ["email": textEmail.text, "password": textPassword.text]) { (json: ResponseSample) in
            self.keyChain.set((json.response?.token)!, forKey: "token", withAccess: nil)
            print(json.status)
            DispatchQueue.main.async {
                let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyEventsVC") as! MyEventsVC
                self.navigationController?.pushViewController(scr, animated: true)
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotButton(_ sender: Any) {
        let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotVC") as! ForgotVC
        navigationController?.pushViewController(scr, animated: true)
    }
}

extension LoginVC: DelegateData {
    func showData(dataUser: String, dataPassword: String) {
        textEmail.text = dataUser
        textPassword.text = dataPassword
    }
}
