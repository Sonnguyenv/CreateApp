
import UIKit

class PopularVC: UIViewController {
    
    var eventsArray  = [EventsPopular]()

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "http://172.16.18.91/18175d1_mobile_100_fresher/public/api/v0/listPopularEvents") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(PopularAPI.self, from: data)
                
                DispatchQueue.main.async {
                    self.eventsArray = (json.response?.events)! 
                    self.myTableView.reloadData()
                }
            } catch {}
        }.resume()
    }
}

extension PopularVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
        cell.nameLable.text = eventsArray[indexPath.row].name
        if let urlImage = URL(string: eventsArray[indexPath.row].photo ?? "") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: urlImage)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imgView.image = image
                    }
                }
            }
        }
        return cell
    }
}

extension PopularVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "InforPopular") as! InforPopularVC
        screen.textRaw = eventsArray[indexPath.row].description_raw ?? ""
        screen.textHTML = eventsArray[indexPath.row].description_html ?? ""
        screen.textStartTime = eventsArray[indexPath.row].schedule_start_time ?? ""
        screen.textEndTime = eventsArray[indexPath.row].schedule_end_time ?? ""
        screen.textStartDate = eventsArray[indexPath.row].schedule_start_date ?? ""
        screen.textEndDate = eventsArray[indexPath.row].schedule_end_date ?? ""
    
        navigationController?.pushViewController(screen, animated: true)
    }
}
