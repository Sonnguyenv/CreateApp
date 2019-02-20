
import UIKit


class InforPopularVC: UIViewController {
    var textRaw = String()
    var textHTML = String()
    var textStartTime = String()
    var textStartDate = String()
    var textEndTime = String()
    var textEndDate = String()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var followedButton: UIButton!
    @IBOutlet weak var descriptionRawLable: UILabel!
    @IBOutlet weak var descriptionHTMLLable: UILabel!
    @IBOutlet weak var startTimeLable: UILabel!
    @IBOutlet weak var startDateLable: UILabel!
    @IBOutlet weak var endTimeLable: UILabel!
    @IBOutlet weak var endDateLable: UILabel!
    
    var eventId = Int()
    var status = Int()
    var venueId = Int()
    let keyChain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if keyChain.get("token") == nil {
            followedButton.isHidden = true
            cancelButton.isHidden = true
        } else {
            followedButton.isHidden = false
            cancelButton.isHidden = false
        }
        descriptionRawLable.text = textRaw.htmlToString
        descriptionHTMLLable.text = textHTML.htmlToString
        startTimeLable.text = textStartTime
        startDateLable.text = textStartDate
        endTimeLable.text = textEndTime
        endDateLable.text = textEndDate
        
    }
    
    func doFollowVenue() {
        print(keyChain.get("token")!)
        postGenericData(urlString: URLString.urlDoFollowVenue, parameters: ["token": keyChain.get("token"), "venue_id": "\(venueId)"]) { (json: PopularAPI) in
            print(json.status)
        }
    }
    
    func doUpdateVeneu() {
        postGenericData(urlString: URLString.urlDoFollowVenue, parameters: ["token": keyChain.get("token"), "status": "\(status)", "event_id": "\(eventId)" ]) { (json: PopularAPI) in
            print(json.status)
        }
    }
    
    @IBAction func followedButton(_ sender: UIButton) {
        sender.flash()
        doFollowVenue()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        sender.flash()
        doUpdateVeneu()
    }
}
