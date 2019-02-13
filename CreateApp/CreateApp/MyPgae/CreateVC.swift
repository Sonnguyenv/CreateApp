
import UIKit

class CreateVC: UIViewController {
    @IBOutlet weak var lableUser: UILabel!
    @IBOutlet weak var lableEmail: UILabel!
    @IBOutlet weak var lablePass: UILabel!
    @IBOutlet weak var lableRepass: UILabel!
    
    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textRepassword: UITextField!
    
    @IBOutlet weak var registerView: UIButton!
    
    var userEmtry = false
    var emailEmtry = false
    var passwordEmtry = false
    var repasswordEmtry = false
    
    var usertext = String()
    var passwordtext = String()
    
    weak var delegate: DelegateData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        registerView.layer.borderWidth = 5
        registerView.layer.cornerRadius = 10
        textUser.text = usertext
    }

    @IBAction func register(_ sender: UIButton) {
        sender.shake()
        delegate?.showData(dataUser: textEmail.text ?? "", dataPassword: textPassword.text ?? "")
        if textPassword.text == textRepassword.text {
            repasswordEmtry = true
        }
        if userEmtry && emailEmtry && passwordEmtry && repasswordEmtry {
            navigationController?.popViewController(animated: true)
        }
    
        //POST Generic Register
        postGenericData(urlString: URLString.urlRegister, parameters: ["name": textUser.text ,"email": textEmail.text, "password": textPassword.text]) { (json: ResponseSample) in
            print(json.status)
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
}

protocol DelegateData : class {
    func showData(dataUser: String, dataPassword: String)
}

extension CreateVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case textUser:
            if textUser.text!.isEmpty {
                lableUser.text = "incorrect"
                userEmtry = false
            } else {
                lableUser.text = String()
                userEmtry = true
            }
        case textEmail:
            if textEmail.text!.contains("@") {
                lableEmail.text = String()
                emailEmtry = true
            } else {
                lableEmail.text = "incorrect"
                emailEmtry = false
            }
        case textPassword:
            if checkPasswordValidation(textPassword.text!) {
                lablePass.text = "incorrect"
                passwordEmtry = false
            } else {
                lablePass.text = String()
                passwordEmtry = true
            }
        case textRepassword:
            if textRepassword != textPassword {
                lableRepass.text = "incorrect"
                repasswordEmtry = false
            } else {
                lableRepass.text = String()
            }
        default: break
        }
    }
}
