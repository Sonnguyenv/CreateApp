
import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    var newsArray = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Generic Get Method
        let nib = UINib.init(nibName: "TableViewCell", bundle: nil)
        myTable.register(nib, forCellReuseIdentifier: "TableViewCell")
        getGenericData(urlString: URLString.urlNews) {(json: NewsAPI) in
            guard let news = json.response?.news else { return }
            DispatchQueue.main.async {
                self.newsArray = news
                self.myTable.reloadData()
            }
        }
    }
}

extension NewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.titleLable.text = newsArray[indexPath.row].title
        cell.descriptionLable.text = newsArray[indexPath.row].author
        
        // MARK: Cache Image
        let urlImageArray = newsArray[indexPath.row].thumb_img
        cell.imagView.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
}

extension NewsVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "InforNews") as! InforNewsVC
        screen.inforNew = newsArray[indexPath.row].description ?? ""
        screen.titleNew = newsArray[indexPath.row].title ?? ""
        screen.author = newsArray[indexPath.row].author ?? ""
        navigationController?.pushViewController(screen, animated: true)
    }
}
