

import UIKit

class ResetPasswordVC: UIViewController {
    @IBOutlet weak var textResetPassword: UITextField!
    @IBOutlet weak var resetView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.resetView.layer.cornerRadius = 10
    }
    @IBAction func resetPassword(_ sender: UIButton) {
        sender.flash()
        
        let parameters = ["email": textResetPassword.text]
        guard let url = URL(string: "http://172.16.18.91/18175d1_mobile_100_fresher/public/api/v0/resetPassword") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        print(httpBody)
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
}
