
import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var signUpView: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var lableUser: UILabel!
    @IBOutlet weak var lableEmail: UILabel!
    @IBOutlet weak var lablePassword: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    let underLine : [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3176470588, green: 0.3725490196, blue: 0.3960784314, alpha: 1),
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]

    var usertext = String()
    var passwordtext = String()
    
    weak var delegate: DelegateData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.isHidden = true
        signUpView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signUpView.layer.borderWidth = 0
        signUpView.layer.cornerRadius = 10
        textUser.text = usertext
        let attributeString = NSMutableAttributedString(string: "Already amember? Login",
                                                        attributes: underLine)
        loginButton.setAttributedTitle(attributeString, for: .normal)
    }

    @IBAction func signUp(_ sender: UIButton) {
        sender.shake()
        self.activity.isHidden = false
        self.view.alpha = 0.8
        self.activity.startAnimating()
        postGenericData(urlString: URLString.urlRegister, parameters: ["name": textUser.text ,"email": textEmail.text, "password": textPassword.text]) { (json: ResponseSample) in
            DispatchQueue.main.async {
                if json.status == 1 {
                    let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self.delegate?.showData(dataUser: self.textEmail.text ?? "")
                    self.navigationController?.pushViewController(scr, animated: true)
                    self.activity.isHidden = true
                    self.view.alpha = 1.0
                    self.activity.stopAnimating()
                } else {
                    let alert = UIAlertController(title: "Error", message: "Can not sign up, pleas try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    self.activity.stopAnimating()
                    self.activity.isHidden = true
                    self.view.alpha = 1.0
                }
            }
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        scr.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        navigationController?.pushViewController(scr, animated: true)
    }
}

    func checkPasswordValidation(_ password: String) -> Bool {
        if password.count <= 8 {
            return true
        }
        for i in password.utf8 {
            if (i >= 40 && i <= 57) || (i >= 65 && i <= 90) {
                return false
            }
        }
        return true
    }

extension SignUpVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case textUser:
            if textUser.text!.isEmpty {
                lableUser.text = "😫😫😫😫😫"
            } else {
                lableUser.text = "😀😀😀😀😀"
            }
        case textEmail:
            if textEmail.text!.contains("@") {
                lableEmail.text = "😀😀😀😀😀"
            } else {
                lableEmail.text = "😫😫😫😫😫"
            }
        case textPassword:
            if checkPasswordValidation(textPassword.text!) {
                lablePassword.text = "😫😫😫😫😫"
            } else {
                lablePassword.text = "😀😀😀😀😀"
            }
        default: break
        }
    }
}

protocol DelegateData : class {
    func showData(dataUser: String)
}
