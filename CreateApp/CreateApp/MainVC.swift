
import UIKit



class MainVC: UIViewController {
    
    @IBOutlet weak var newsButton: UIButton!
    @IBOutlet weak var popularButton: UIButton!
    var page: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsButton.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.1843137255, alpha: 1)
        popularButton.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PageViewController,
            segue.identifier == "PageViewController" {
            self.page = vc
        }
    }
    
   
    @IBAction func preNews(_ sender: Any) {
        page?.moveToPage(0)
        newsButton.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.1843137255, alpha: 1)
        popularButton.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
    }
    
    @IBAction func buttonReleased(_ sender: Any) {
        page?.moveToPage(0)
        newsButton.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
    }
    
    @IBAction func nextPopular(_ sender: Any) {
        page?.moveToPage(1)
        popularButton.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1294117647, blue: 0.1843137255, alpha: 1)
        newsButton.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
    }
    
    @IBAction func popularReleased(_ sender: Any) {
        page?.moveToPage(1)
        popularButton.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
    }
    
}

