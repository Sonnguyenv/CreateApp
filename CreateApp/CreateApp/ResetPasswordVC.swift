

import UIKit

class ResetPasswordVC: UIViewController {
    @IBOutlet weak var textResetPassword: UITextField!
    @IBOutlet weak var resetView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        resetView.layer.borderWidth = 5
        resetView.layer.cornerRadius = 10
//        textResetPassword.text = "dreamsonss@gmail.com"
    }
    @IBAction func resetPassword(_ sender: UIButton) {
        sender.flash()
        
        let parameters = ["email": textResetPassword.text]
        guard let url = URL(string: "http://172.16.18.91/18175d1_mobile_100_fresher/public/api/v0/resetPassword") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(ResponseSample.self, from: data)
                } catch {}
            }
        }.resume()
    }
}
