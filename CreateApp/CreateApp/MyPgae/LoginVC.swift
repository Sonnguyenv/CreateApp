
import UIKit



class LoginVC: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var loginView: UIButton!
    @IBOutlet weak var accountView: UIView!
    
    let keyChain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        loginView.layer.borderWidth = 5
        loginView.layer.cornerRadius = 10
        textEmail.text = "dreamsonss@gmail.com"
        textPassword.text = "NmpXvfq1"
    }
    
    override func viewDidLayoutSubviews() {
        if keyChain.get("token") == nil {
        accountView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: accountView.bounds.height)
        } else {
            accountView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: accountView.bounds.height)
        }
    }
    
    @IBAction func creatAccount(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "CreateVC") as! CreateVC
        screen.delegate = self
        screen.usertext = textEmail.text ?? ""
        screen.passwordtext = textPassword.text ?? ""
        navigationController?.pushViewController(screen, animated: true)
    }
    
    @IBAction func login(_ sender: UIButton) {
        sender.pulsate()
        // MARK: POST Generic Login
        postGenericData(urlString: URLString.urlLogin, parameters: ["email": textEmail.text, "password": textPassword.text]) { (json: ResponseSample) in
            self.keyChain.set((json.response?.token)!, forKey: "token", withAccess: nil)
            DispatchQueue.main.async {
                self.accountView.center.y = self.view.bounds.height/2
            }
            
        }
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        navigationController?.pushViewController(screen, animated: true)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        accountView.center.y = view.bounds.height * 1.5
        keyChain.delete("token")
    }
    
    @IBAction func listEventButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "MyEventsVC") as! MyEventsVC
        navigationController?.pushViewController(screen, animated: true)
    }
    
}

extension LoginVC: DelegateData {
    func showData(dataUser: String, dataPassword: String) {
        textEmail.text = dataUser
        textPassword.text = dataPassword
    }
}
