
import UIKit



class MainVC: UIViewController {
    
    @IBOutlet weak var newsButton: UIButton!
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy var newsSubview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
    lazy var popularSubview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopularVC") as! PopularVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: view.bounds.width * 2, height: scrollView.bounds.height)
        addSubview([newsSubview.view, popularSubview.view])
    }
    
    func addSubview(_ subview: [UIView]) {
        for i in 0..<subview.count {
            subview[i].frame = CGRect(x: self.view.bounds.width * CGFloat(i), y: 0, width: self.scrollView.bounds.width, height: self.scrollView.bounds.height)
            scrollView.addSubview(subview[i])
        }
    }
    
    @IBAction func newsButton(_ sender: Any) {
        
    }
    @IBAction func popularButton(_ sender: Any) {
        
    }
}

