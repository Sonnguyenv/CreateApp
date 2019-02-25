
import UIKit

class PopularVC: UIViewController {
    
    var index = 0
    var categoryID = 0
    
    var eventsArray  = [EventsPopular]()
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Generic Get Method
        let nib = UINib.init(nibName: "TableViewCell", bundle: nil)
        myTable.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        if index == 0 {
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
}

extension PopularVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "TableViewCell") as! TableViewCell
        cell.titleLable.text = eventsArray[indexPath.row].name
        cell.descriptionLable.text = eventsArray[indexPath.row].description_raw?.htmlToString
        cell.startDateLable.text = eventsArray[indexPath.row].schedule_start_date
        //MARK: Cache Image
        let urlImageArray = eventsArray[indexPath.row].photo
        cell.imagView.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
}

extension PopularVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "InforPopular") as! InforPopularVC
        screen.textName = eventsArray[indexPath.row].name ?? ""
        screen.textNameVenue = eventsArray[indexPath.row].venue?.name ?? ""
        screen.textStartDate = eventsArray[indexPath.row].schedule_start_date ?? ""
        screen.textDescriptionRaw = eventsArray[indexPath.row].description_raw ?? ""
        //MARK: Cache Image
        let urlImageArray = eventsArray[indexPath.row].photo
        screen.urlPhotoString = urlImageArray ?? ""
        screen.textLocation = eventsArray[indexPath.row].venue?.description ?? ""
        screen.eventsArrayInfor = eventsArray
        navigationController?.pushViewController(screen, animated: true)
        
    }
}


