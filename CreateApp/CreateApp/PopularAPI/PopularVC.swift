
import UIKit

class PopularVC: UIViewController {
    
    var index       = 0
    var categoryID  = 0
    var eventsArray = [EventsPopular]()
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "TableViewCell", bundle: nil)
        myTable.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        // MARK: Generic Get Method
        if index == 0 {
            myView.isHidden = true
            getGenericData(urlString: URLString.urlPopular) { (json: PopularAPI) in
                guard let events = json.response?.events else { return }
                DispatchQueue.main.async {
                    self.eventsArray = events
                    self.myTable.reloadData()
                }
            }
        } else {
            getGenericData(urlString: URLString.urlListEventsByCategory + "?pageIndex=1&pageSize=10&&category_id=\(categoryID)") { (json: PopularAPI) in
                guard let events = json.response?.events else { return }
                DispatchQueue.main.async {
                    self.eventsArray = events
                    self.myTable.reloadData()
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension PopularVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "TableViewCell") as! TableViewCell
        cell.titleLable.text       = eventsArray[indexPath.row].name
        cell.descriptionLable.text = eventsArray[indexPath.row].description_raw?.htmlToString
        cell.startDateLable.text   = eventsArray[indexPath.row].schedule_start_date
        //MARK: Cache Image
        let urlImageArray = eventsArray[indexPath.row].photo
        cell.imagView.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
}

extension PopularVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InforPopularVC") as! InforPopularVC
        scr.textName           = eventsArray[indexPath.row].name ?? ""
        scr.textNameVenue      = eventsArray[indexPath.row].venue?.name ?? ""
        scr.textStartDate      = eventsArray[indexPath.row].schedule_start_date ?? ""
        scr.textDescriptionRaw = eventsArray[indexPath.row].description_raw ?? ""
        //MARK: Cache Image
        let urlImageArray    = eventsArray[indexPath.row].photo
        scr.urlPhotoString   = urlImageArray ?? ""
        scr.eventsArrayInfor = eventsArray
        scr.eventId          = eventsArray[indexPath.row].id
        scr.venueId          = (eventsArray[indexPath.row].venue?.id)!
        present(scr, animated: true, completion: nil)
    }
}


