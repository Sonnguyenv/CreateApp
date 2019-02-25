//
//  MyEvents.swift
//  CreateApp
//
//  Created by Sonnv on 2/20/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class MyEventsVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var listGoing = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListEventWillGoVC") as! GoingVC
    lazy var listWent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListEventGoneVC") as! WentVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: view.bounds.width * 2, height: scrollView.bounds.height)
        addSubview([listGoing.view, listWent.view])
    }
    
    func addSubview(_ subview: [UIView]) {
        for i in 0..<subview.count {
            subview[i].frame = CGRect(x: self.view.bounds.width * CGFloat(i), y: 0, width: self.scrollView.bounds.width, height: self.scrollView.bounds.height)
            scrollView.addSubview(subview[i])
        }
    }
}
