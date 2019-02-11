
import UIKit
import MapKit
import CoreLocation

class NearVC: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.stopUpdatingLocation()
        let location =
            CLLocationCoordinate2DMake(21.017854, 105.781125)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = location
        dropPin.title = "Hello"
        dropPin.subtitle = "Hi"
        mapView.addAnnotation(dropPin)
    }
}
