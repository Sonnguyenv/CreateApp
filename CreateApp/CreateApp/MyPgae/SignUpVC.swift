
import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var signUpView: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    let underLine : [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3176470588, green: 0.3725490196, blue: 0.3960784314, alpha: 1),
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
    
    var userEmtry = false
    var emailEmtry = false
    var passwordEmtry = false
    var repasswordEmtry = false
    
    var usertext = String()
    var passwordtext = String()
    
    weak var delegate: DelegateData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        delegate?.showData(dataUser: textEmail.text ?? "", dataPassword: textPassword.text ?? "")
        postGenericData(urlString: URLString.urlRegister, parameters: ["name": textUser.text ,"email": textEmail.text, "password": textPassword.text]) { (json: ResponseSample) in
        }
        if textPassword.text == textPassword.text {
            repasswordEmtry = true
        }
        if userEmtry && emailEmtry && passwordEmtry && repasswordEmtry {
        }
        let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(scr, animated: true)
//        MARK: POST Generic Register
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
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

protocol DelegateData : class {
    func showData(dataUser: String, dataPassword: String)
    }

extension SignUpVC: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case textUser:
            if textUser.text!.isEmpty {
                textUser.text = "incorrect"
                userEmtry = false
            } else {
//                lableUser.text = String()
                userEmtry = true
            }
        case textEmail:
            if textEmail.text!.contains("@") {
//                lableEmail.text = String()
                emailEmtry = true
            } else {
                textEmail.text = "incorrect"
                emailEmtry = false
            }
        case textPassword:
            if checkPasswordValidation(textPassword.text!) {
                textPassword.text = "incorrect"
                passwordEmtry = false
            } else {
//                lablePass.text = String()
                passwordEmtry = true
            }
        default: break
        }
    }
}
