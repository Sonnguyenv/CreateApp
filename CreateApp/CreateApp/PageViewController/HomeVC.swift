
import UIKit

class HomeVC: UIViewController {
 
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var newsButtonView: UIButton!
    @IBOutlet weak var popularButtonView: UIButton!
    var page: PageViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PageViewController,
            segue.identifier == "PageViewController" {
            self.page = vc
            vc.delegatColor = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func newsButton(_ sender: Any) {
        page?.moveToPage(0)
        newsView.backgroundColor    = #colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1)
        newsButtonView.setTitleColor(#colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1), for: .normal)
        popularView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        popularButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    @IBAction func popularButton(_ sender: Any) {
        page?.moveToPage(1)
        popularView.backgroundColor = #colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1)
        popularButtonView.setTitleColor(#colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1), for: .normal)
        newsView.backgroundColor    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        newsButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
}

extension HomeVC: DelegateColor {
    func colorbutton(index: Int) {
        if index == 0 {
            newsView.backgroundColor    = #colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1)
            newsButtonView.setTitleColor(#colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1), for: .normal)
            popularView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            popularButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        } else {
            popularView.backgroundColor = #colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1)
            popularButtonView.setTitleColor(#colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1), for: .normal)
            newsView.backgroundColor    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            newsButtonView.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
    }
}
