
import UIKit
import MapKit
import CoreLocation

class NearVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var long = Double()
    var lat = Double()
    
    var nearArray = [EventsPopular]()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            mapView.showsUserLocation = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        let nib = UINib.init(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func getNearlyEvents() {
        getGenericData(urlString: URLString.urlListNearlyEvents + "?radius=200&longitue=\(long)&latitude=\(lat)") { (json: PopularAPI) in
            self.nearArray = json.response?.events ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension NearVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            long = location.coordinate.longitude
            lat = location.coordinate.latitude
            getNearlyEvents()
        }
    }
}

extension NearVC: UICollectionViewDataSource {
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

extension NearVC: UICollectionViewDelegate {
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

extension NearVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: collectionView.frame.height)
    }
}
