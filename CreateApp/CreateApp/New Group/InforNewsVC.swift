

import UIKit

class InforNewsVC: UIViewController {
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var inforLable: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var authorLable: UILabel!
    
    var titleNew = String()
    var inforNew = String()
    var author = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNews.text = titleNew
        inforLable.text = inforNew
        authorLable.text = author
        
        let btnA = UIButton.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.navigationController?.navigationItem.hidesBackButton = true
        btnA.backgroundColor = UIColor.green
        let buttonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = buttonItem
    }

}
