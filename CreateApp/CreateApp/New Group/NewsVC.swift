
import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    
    var newsArray = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = URL(string: "http://172.16.18.91/18175d1_mobile_100_fresher/public/api/v0/listNews") else { return }
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(NewsAPI.self, from: data)
            
                DispatchQueue.main.async {
                    self.newsArray = (json.response?.news)!
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
        cell.titleLable.text = newsArray[indexPath.row].title
        cell.dateLable.text = newsArray[indexPath.row].publish_date
        if let urlImage = URL(string: newsArray[indexPath.row].thumb_img ?? "") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: urlImage)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imgeView.image = image
                    }
                }
            }
        }
        
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
