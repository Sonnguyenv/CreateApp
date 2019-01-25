
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textUser: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var loginView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        loginView.layer.borderWidth = 5
        loginView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = ""
    }
    
    @IBAction func creatAccount(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "CreateVC") as! CreateVC
        screen.delegate = self
        screen.usertext = textUser.text ?? ""
        screen.passwordtext = textPassword.text ?? ""
        navigationController?.pushViewController(screen, animated: true)
    }
    @IBAction func login(_ sender: UIButton) {
        sender.pulsate()
        if (textUser.text?.isEmpty)! && (textPassword.text?.isEmpty)! || (textUser.text?.isEmpty)! || (textPassword.text?.isEmpty)! {
            print("Error")
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let screen = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            navigationController?.pushViewController(screen, animated: true)
            // POST URL
            let parameters = ["email": textUser.text, "password": textPassword.text]
            guard let url = URL(string: "http://172.16.18.91/18175d1_mobile_100_fresher/public/api/v0/login") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {}
                }
            }.resume()
        }
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let screen = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        navigationController?.pushViewController(screen, animated: true)
    }
}

extension ViewController: Delegate {
    func showData(dataUser: String, dataPassword: String) {
        textUser.text = dataUser
        textPassword.text = dataPassword
    }
}

