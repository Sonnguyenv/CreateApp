
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func creatAccount(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "CreateVC") as! CreateVC
        screen.delegate = self
        screen.usertext = textUser.text ?? ""
        screen.passwordtext = textPassword.text ?? ""
        navigationController?.pushViewController(screen, animated: true)
    }
    @IBAction func login(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "LoginSuccseVC") as! LoginSuccseVC
        if textUser.text!.isEmpty {
            screen.textTitle = "Fail"
            navigationController?.pushViewController(screen, animated: true)
        } else {
            screen.textTitle = "Succsefully"
            navigationController?.pushViewController(screen, animated: true)
        }
    }
}

extension ViewController: Delegate {
    func showData(dataUser: String, dataPassword: String) {
        textUser.text = dataUser
        textPassword.text = dataPassword
    }
}
