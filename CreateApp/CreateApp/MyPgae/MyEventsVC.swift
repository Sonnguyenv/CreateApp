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
    var page:PageController!
    @IBOutlet weak var goingButtonView: UIButton!
    @IBOutlet weak var wentButtonView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PageController,
            segue.identifier == "PageController" {
            self.page = vc
            vc.colorButtonDelegate = self as? ColorButtonDelegate
        }
    }
    
    @IBAction func goingButton(_ sender: Any) {
//        goingButtonView.setTitleColor(#colorLiteral(red: 0.337254902, green: 0.1960784314, blue: 0.6823529412, alpha: 1), for: .normal)
//        wentButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        page?.moveToPage(0)
    }
    
    @IBAction func wentButton(_ sender: Any) {
//        wentButtonView.setTitleColor(#colorLiteral(red: 0.337254902, green: 0.1960784314, blue: 0.6823529412, alpha: 1), for: .normal)
//        goingButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        page?.moveToPage(1)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        keyChain.delete("token")
        TabBarVC.instance.undateTabBar()
    }
}

//extension MyEventsVC: ChangeColor {
//    func colorbutton(index: Int) {
//        if index == 0 {
//            goingButtonView.setTitleColor(#colorLiteral(red: 0.337254902, green: 0.1960784314, blue: 0.6823529412, alpha: 1), for: .normal)
//            wentButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//        } else {
//            goingButtonView.setTitleColor(#colorLiteral(red: 0.337254902, green: 0.1960784314, blue: 0.6823529412, alpha: 1), for: .normal)
//            wentButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//        }
//    }
//}

extension MyEventsVC: ColorButtonDelegate {
    func colorButton(_ index: Int) {
        print(index)
        if index == 1 {
            goingButtonView.setTitleColor(#colorLiteral(red: 0.337254902, green: 0.1960784314, blue: 0.6823529412, alpha: 1), for: .normal)
            wentButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        } else if index == 2 {
            goingButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            wentButtonView.setTitleColor(#colorLiteral(red: 0.337254902, green: 0.1960784314, blue: 0.6823529412, alpha: 1), for: .normal)
        }
    }
}
