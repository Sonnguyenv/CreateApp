//
//  MyEvents.swift
//  CreateApp
//
//  Created by Sonnv on 2/20/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class MyEventsVC: UIViewController {
    
    let keyChain = KeychainSwift()
    
    @IBOutlet weak var goingButtonView: UIButton!
    @IBOutlet weak var wentButtonView: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var listGoing = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GoingVC") as! GoingVC
    lazy var listWent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WentVC") as! WentVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goingButtonView.setTitleColor(#colorLiteral(red: 0.337254902, green: 0.1960784314, blue: 0.6823529412, alpha: 1), for: .normal)
        scrollView.contentSize = CGSize(width: view.bounds.width * 2, height: scrollView.bounds.height)
        addSubview([listGoing.view, listWent.view])
    }
    
    @IBAction func goingButton(_ sender: Any) {
        goingButtonView.setTitleColor(#colorLiteral(red: 0.337254902, green: 0.1960784314, blue: 0.6823529412, alpha: 1), for: .normal)
        wentButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    @IBAction func wentButton(_ sender: Any) {
        wentButtonView.setTitleColor(#colorLiteral(red: 0.337254902, green: 0.1960784314, blue: 0.6823529412, alpha: 1), for: .normal)
        goingButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    @IBAction func logOutButton(_ sender: Any) {
        keyChain.delete("token")
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func addSubview(_ subview: [UIView]) {
        for i in 0..<subview.count {
            subview[i].frame = CGRect(x: self.view.bounds.width * CGFloat(i), y: 0, width: self.scrollView.bounds.width, height: self.scrollView.bounds.height)
            scrollView.addSubview(subview[i])
        }
    }
}
