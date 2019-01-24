
import UIKit

class InforPopularVC: UIViewController {
    var textRaw = String()
    var textHTML = String()
    var textStartTime = String()
    var textStartDate = String()
    var textEndTime = String()
    var textEndDate = String()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var descriptionRawLable: UILabel!
    @IBOutlet weak var descriptionHTMLLable: UILabel!
    @IBOutlet weak var startTimeLable: UILabel!
    @IBOutlet weak var startDateLable: UILabel!
    @IBOutlet weak var endTimeLable: UILabel!
    @IBOutlet weak var endDateLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionRawLable.text = textRaw.htmlToString
        descriptionHTMLLable.text = textHTML.htmlToString
        startTimeLable.text = textStartTime
        startDateLable.text = textStartDate
        endTimeLable.text = textEndTime
        endDateLable.text = textEndDate
    }
}
