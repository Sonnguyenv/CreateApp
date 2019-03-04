
import UIKit


class InforPopularVC: UIViewController {
    
    var textName = String()
    var textNameVenue = String()
    var textDescriptionRaw = String()
    var textStartDate = String()
    var urlPhotoString = String()
    
    var eventsArrayInfor = [EventsPopular]()
    var nearArray = [EventsPopular]()
    
    @IBOutlet weak var imagePopular: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    var eventId  = Int()
    var status   = Int()
    var venueId  = Int()
    let keyChain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let nib = UINib.init(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        
        self.buttonView()
        getGenericData(urlString: URLString.urlGetDetailEvent + "?event_id=\(eventId)") { (json: PopularDetail) in
            guard let near = json.response?.events else {return}
            let long = near.venue?.geo_long
            let lat = near.venue?.geo_lat
            self.getNearlyEvents(long!, lat!)
            DispatchQueue.main.async {
                self.inforContactLable.text  = near.venue?.contact_phone
                self.inforLocationLable.text = near.venue?.contact_address
                self.inforNameLable.text     = near.venue?.description
                self.inforGenerLable.text    = near.venue?.name
            }
        }
        
        imagePopular.cacheImage(urlString: urlPhotoString)
        nameVenueLable.text      = textNameVenue
        nameLable.text           = textName
        startDateLable.text      = textStartDate
        descriptionRawLable.text = textDescriptionRaw.htmlToString
    }
    
    func buttonView() {
        followButton.layer.borderColor  = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        followButton.layer.borderWidth  = 0
        followButton.layer.cornerRadius = 5
        
        goingButton.layer.borderColor  = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        goingButton.layer.borderWidth  = 0
        goingButton.layer.cornerRadius = 5
        
        wentButton.layer.borderColor  = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        wentButton.layer.borderWidth  = 0
        wentButton.layer.cornerRadius = 5
    }
    
    func getNearlyEvents(_ long: String, _ lat: String) {
        getGenericData(urlString: URLString.urlListNearlyEvents + "?radius=200&longitue=\(long)&latitude=\(lat)") { (json: PopularAPI) in
            self.nearArray = json.response?.events ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
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
    
    @IBAction func goingButton(_ sender: UIButton) {
        sender.shake()
        status = 1
        doUpdateVeneu()
    }
    
    @IBAction func wentButton(_ sender: UIButton) {
        sender.shake()
        status = 2
        doUpdateVeneu()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension InforPopularVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.layer.borderWidth         = 1
        cell.layer.borderColor         = #colorLiteral(red: 0.3960784314, green: 0.4666666667, blue: 0.4901960784, alpha: 1)
        cell.nameVenueLable.text       = nearArray[indexPath.row].name
        cell.nameDescriptionLable.text = nearArray[indexPath.row].description_html?.htmlToString
        cell.startTimeLable.text       = nearArray[indexPath.row].schedule_start_date
        let urlImageArray              = nearArray[indexPath.row].photo
        cell.phtoView.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
}

extension InforPopularVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InforPopularVC") as! InforPopularVC
        scr.textName           = nearArray[indexPath.row].name ?? ""
        scr.textNameVenue      = nearArray[indexPath.row].venue?.name ?? ""
        scr.textStartDate      = nearArray[indexPath.row].schedule_start_date ?? ""
        scr.textDescriptionRaw = nearArray[indexPath.row].description_raw ?? ""
        //MARK: Cache Image
        let urlImageArray    = nearArray[indexPath.row].photo
        scr.urlPhotoString   = urlImageArray ?? ""
        scr.eventsArrayInfor = nearArray
        scr.eventId          = nearArray[indexPath.row].id
        scr.status           = nearArray[indexPath.row].status
        present(scr, animated: true, completion: nil)
    }
}

extension InforPopularVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: collectionView.frame.height)
    }
}

