
import UIKit

class BrowsVC: UIViewController {
    
    var categoriesArray = [Categories]()
    var evenArraySearch = [EventsPopular]()
    
    @IBOutlet weak var browsTableCell: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGenericData(urlString: URLString.urlListCategories + "?pageIndex=1&pageSize=10") { (json: CategoriesAPI) in
            guard let categories = json.response?.categories else { return }
            DispatchQueue.main.async {
                self.categoriesArray = categories
                self.browsTableCell.reloadData()
            }
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        navigationController?.pushViewController(screen, animated: true)
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
        screen.index = 1
        navigationController?.pushViewController(screen, animated: true)
    }
}

