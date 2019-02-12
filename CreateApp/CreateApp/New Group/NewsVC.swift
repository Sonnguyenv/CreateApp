
import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    
    var newsArray = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = URL(string: URlString.urlNews) else { return }
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(NewsAPI.self, from: data)
                guard let news = json.response?.news else { return }
                DispatchQueue.main.async {
                    self.newsArray = news
                    self.myTable.reloadData()
                }
            } catch {}
        }.resume()
    }
}

extension NewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        cell.titleLableNews.text = newsArray[indexPath.row].title
        cell.dateLableNews.text = newsArray[indexPath.row].publish_date
        // Cache Image
        let urlImageArray = newsArray[indexPath.row].thumb_img
        cell.imgeNews.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
}

extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "InforNews") as! InforNewsVC
        screen.inforNew = newsArray[indexPath.row].description ?? ""
        screen.titleNew = newsArray[indexPath.row].title ?? ""
        screen.author = newsArray[indexPath.row].author ?? ""
        navigationController?.pushViewController(screen, animated: true)
    }
}
