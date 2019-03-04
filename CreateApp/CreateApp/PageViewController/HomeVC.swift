
import UIKit

class HomeVC: UIViewController {
 
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var popularView: UIView!
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
        newsView.backgroundColor    = #colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1)
        popularView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @IBAction func newsButton(_ sender: Any) {
        page?.moveToPage(0)
        newsView.backgroundColor    = #colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1)
        popularView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    @IBAction func popularButton(_ sender: Any) {
        page?.moveToPage(1)
        popularView.backgroundColor = #colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1)
        newsView.backgroundColor    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}

extension HomeVC: DelegateColor {
    func colorbutton(index: Int) {
        if index == 0 {
            newsView.backgroundColor = #colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1)
            popularView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            newsView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 1, alpha: 1)
            popularView.backgroundColor = #colorLiteral(red: 0.4873705058, green: 0.2180508075, blue: 0.6901960784, alpha: 1)
        }
    }
}
