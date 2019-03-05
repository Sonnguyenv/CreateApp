
import UIKit

class BrowsVC: UIViewController {
    
    
    
    var categoriesArray = [Categories]()
    var evenArraySearch = [EventsPopular]()
    
    @IBOutlet weak var browsTableCell: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getGenericData(urlString: URLString.urlListCategories) { (json: CategoriesAPI) in
            guard let categories = json.response?.categories else { return }
            DispatchQueue.main.async {
                self.categoriesArray = categories
                self.browsTableCell.reloadData()
            }
        }
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        navigationController?.pushViewController(scr, animated: true)
    }
}

extension BrowsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrowsTableViewCell") as! BrowsTableViewCell
        cell.nameLable.text = categoriesArray[indexPath.row].name
        cell.layer.cornerRadius = 3
        cell.layer.borderWidth  = 1
        cell.layer.borderColor  = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.7) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

extension BrowsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopularVC") as! PopularVC
        scr.categoryID = categoriesArray[indexPath.row].id
        scr.index      = 1
        scr.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        present(scr, animated: true, completion: nil)
    }
}

