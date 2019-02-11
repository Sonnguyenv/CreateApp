
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var loginView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        loginView.layer.borderWidth = 5
        loginView.layer.cornerRadius = 10
        textEmail.text = "dreamsonss@gmail.com"
        textPassword.text = "Daucoma123"
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
            let parameters = ["email": textEmail.text, "password": textPassword.text] as? Decodable
            guard let url = URL(string: "http://172.16.18.91/18175d1_mobile_100_fresher/public/api/v0/login") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        guard let json = try JSONDecoder().decode(parameters.self, from: data) else { return }
                        print(json)
                    } catch {}
                }
            }.resume()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        navigationController?.pushViewController(screen, animated: true)
        }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        navigationController?.pushViewController(screen, animated: true)
    }
}

extension ViewController: DelegateData {
    func showData(dataUser: String, dataPassword: String) {
        textEmail.text = dataUser
        textPassword.text = dataPassword
    }
}
