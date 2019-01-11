//
//  LoginSuccseVC.swift
//  CreateApp
//
//  Created by Sonnv on 1/11/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class LoginSuccseVC: UIViewController {
    var textTitle: String = ""
    @IBOutlet weak var lableLogin: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lableLogin.text = textTitle
    }
}
