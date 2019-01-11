
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
    
    var userEmtry = false
    var emailEmtry = false
    var passwordEmtry = false
    var repasswordEmtry = false
    
    var usertext:String = ""
    var passwordtext:String = ""
    
    weak var delegate: Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textUser.text = usertext
    }

    @IBAction func register(_ sender: Any) {
        delegate?.showData(dataUser: textUser.text ?? "", dataPassword: textPassword.text ?? "")
        if textPassword.text == textRepassword.text {
            repasswordEmtry = true
        }
        if userEmtry && emailEmtry && passwordEmtry && repasswordEmtry {
            navigationController?.popViewController(animated: true)
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

protocol Delegate : class {
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
                lableUser.text = ""
                userEmtry = true
            }
        case textEmail:
            if textEmail.text!.contains("@") {
                lableEmail.text = ""
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
                lablePass.text = ""
                passwordEmtry = true
            }
        case textRepassword:
            if textRepassword != textPassword {
                lableRepass.text = "incorrect"
                repasswordEmtry = false
            } else {
                lableRepass.text = ""
            }
        default: break
        }
    }
}
