
import UIKit

class BrowsVC: UIViewController {

    var categoriesArray = [Categories]()
    var searchArray = [Categories]()
    var evenArraySearch = [EventsPopular]()
    var searching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var BrowsTableCell: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlCategories = URL(string: URlString.urlListCategories) else { return }
        URLSession.shared.dataTask(with: urlCategories) { (data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(CategoriesAPI.self, from: data)
                guard let categories = json.response?.categories else { return }
                DispatchQueue.main.async {
                    self.categoriesArray = categories
                    self.BrowsTableCell.reloadData()
                }
            }catch{}
        }.resume()
    }
}

extension BrowsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrowsTableViewCell") as! BrowsTableViewCell
        cell.nameLable.text = categoriesArray[indexPath.row].name
        return cell
    }
}

extension BrowsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "PopularVC") as! PopularVC
        screen.categoryID = categoriesArray[indexPath.row].id
        navigationController?.pushViewController(screen, animated: true)
    }
}

