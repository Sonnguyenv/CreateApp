
import UIKit

class PopularVC: UIViewController {
    
    var index = 0
    var categoryID = 0
    
    var eventsArray  = [EventsPopular]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Generic Get Method
        if index == 0 {
            getGenericData(urlString: URLString.urlPopular) { (json: PopularAPI) in
                guard let events = json.response?.events else { return }
                DispatchQueue.main.async {
                    self.eventsArray = events
                    self.myTableView.reloadData()
                }
            }
        } else {
            getGenericData(urlString: URLString.urlListEventsByCategory + "?pageIndex=1&pageSize=10&&category_id=\(categoryID)") { (json: PopularAPI) in
            guard let events = json.response?.events else { return }
            DispatchQueue.main.async {
                self.eventsArray = events
                self.myTableView.reloadData()
                }
            }
        }
    }
}

extension PopularVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "PopularTableViewCell") as! PopularTableViewCell
        cell.nameLablePopular.text = eventsArray[indexPath.row].name
        cell.descriptionRaw.text = eventsArray[indexPath.row].description_raw?.htmlToString
        cell.startDateLable.text = eventsArray[indexPath.row].schedule_start_date
        //MARK: Cache Image
        let urlImageArray = eventsArray[indexPath.row].photo
        cell.imgPopular.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
}

extension PopularVC: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "InforPopular") as! InforPopularVC
        screen.textRaw = eventsArray[indexPath.row].description_raw ?? ""
        screen.textHTML = eventsArray[indexPath.row].description_html ?? ""
        screen.textStartTime = eventsArray[indexPath.row].schedule_start_time ?? ""
        screen.textEndTime = eventsArray[indexPath.row].schedule_end_time ?? ""
        screen.textStartDate = eventsArray[indexPath.row].schedule_start_date ?? ""
        screen.textEndDate = eventsArray[indexPath.row].schedule_end_date ?? ""
        screen.venueId = (eventsArray[indexPath.row].venue?.id)!
        screen.status = eventsArray[indexPath.row].status
        screen.eventId = eventsArray[indexPath.row].id
        navigationController?.pushViewController(screen, animated: true)
    }
}


