
import UIKit



class LoginVC: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var loginView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        loginView.layer.borderWidth = 5
        loginView.layer.cornerRadius = 10
        textEmail.text = "dreamsonss@gmail.com"
        textPassword.text = "NmpXvfq1"
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
//        POST Method Login
        let parameters = ["email": textEmail.text, "password": textPassword.text]
        guard let urlLogin = URL(string: "http://172.16.18.91/18175d1_mobile_100_fresher/public/api/v0/login") else { return }
        var request = URLRequest(url: urlLogin)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ResponseSample.self, from: data)
                        DispatchQueue.main.async {
                            if json.status == 1 {
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let screen = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                                self.navigationController?.pushViewController(screen, animated: true)
                            } else {
                                print("Error")
                            }
                        }
                } catch {}
            }
        }.resume()
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        navigationController?.pushViewController(screen, animated: true)
    }
}

extension LoginVC: DelegateData {
    func showData(dataUser: String, dataPassword: String) {
        textEmail.text = dataUser
        textPassword.text = dataPassword
    }
}
