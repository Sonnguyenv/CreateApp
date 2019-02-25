
import UIKit


class InforPopularVC: UIViewController {
    
    var textName = String()
    var textNameVenue = String()
    var textDescriptionRaw = String()
    var textStartDate = String()
    var urlPhotoString = String()
    var textLocation = String()
    var textGener = String()
    var textContact = String()
    var eventsArrayInfor = [EventsPopular]()
    
    @IBOutlet weak var imagePopular: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var wentButton: UIButton!
    @IBOutlet weak var goingButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var nameVenueLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var startDateLable: UILabel!
    @IBOutlet weak var descriptionRawLable: UILabel!
    
    @IBOutlet weak var inforNameLable: UILabel!
    @IBOutlet weak var inforGenerLable: UILabel!
    @IBOutlet weak var inforLocationLable: UILabel!
    @IBOutlet weak var inforContactLable: UILabel!
    
    
    var eventId = Int()
    var status = Int()
    var venueId = Int()
    let keyChain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followButton.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        followButton.layer.borderWidth = 3
        followButton.layer.cornerRadius = 8
        
        goingButton.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        goingButton.layer.borderWidth = 3
        goingButton.layer.cornerRadius = 8
        
        wentButton.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        wentButton.layer.borderWidth = 3
        wentButton.layer.cornerRadius = 8
        
        if keyChain.get("token") == nil {
            wentButton.isHidden = true
            goingButton.isHidden = true
        } else {
            wentButton.isHidden = false
            goingButton.isHidden = false
        }
        
        imagePopular.cacheImage(urlString: urlPhotoString)
        nameVenueLable.text = textNameVenue
        nameLable.text = textName
        startDateLable.text = textStartDate
        descriptionRawLable.text = textDescriptionRaw.htmlToString
        
        inforNameLable.text = textName
        inforGenerLable.text = textGener
        inforContactLable.text = textContact
        inforLocationLable.text = textLocation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func doFollowVenue() {
        postGenericData(urlString: URLString.urlDoFollowVenue, parameters: ["token": keyChain.get("token"), "venue_id": "\(venueId)"]) { (json: PopularAPI) in
            print(json.status)
        }
    }
    
    func doUpdateVeneu() {
        postGenericData(urlString: URLString.urlDoFollowVenue, parameters: ["token": keyChain.get("token"), "status": "\(status)", "event_id": "\(eventId)"]) { (json: PopularAPI) in
        }
    }
    
    @IBAction func followedButton(_ sender: UIButton) {
        sender.flash()
        doFollowVenue()
    }
    
    @IBAction func goingButton(_ sender: Any) {
        doUpdateVeneu()
    }
    
    @IBAction func wentButton(_ sender: Any) {
        
    }
}

extension InforPopularVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsArrayInfor.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InforPopularCollectionViewCell", for: indexPath) as! InforPopularCollectionViewCell
        cell.nameVenueLable.text = eventsArrayInfor[indexPath.row].name
        cell.nameDescriptionLable.text = eventsArrayInfor[indexPath.row].description_html?.htmlToString
        cell.startTimeLable.text = eventsArrayInfor[indexPath.row].schedule_start_date
        let urlImageArray = eventsArrayInfor[indexPath.row].photo
        cell.phtoView.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
}

extension InforPopularVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: collectionView.frame.height)
    }
}

extension InforPopularVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
