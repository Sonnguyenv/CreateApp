
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var loginView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = ""
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
        let screen = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            navigationController?.pushViewController(screen, animated: true)
    }
}

extension ViewController: Delegate {
    func showData(dataUser: String, dataPassword: String) {
        textUser.text = dataUser
        textPassword.text = dataPassword
    }
}

