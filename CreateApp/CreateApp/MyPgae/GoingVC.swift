//
//  ListEventWillGoVC.swift
//  CreateApp
//
//  Created by Sonnv on 2/20/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class GoingVC: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "TableViewCell", bundle: nil)
        myTable.register(nib, forCellReuseIdentifier: "TableViewCell")
        getGenericData(urlString: URLString.urlListMyEvents) { (json: PopularAPI) in
//            guard let 
        }
    }
}
