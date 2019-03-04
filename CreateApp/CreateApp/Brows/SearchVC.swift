//
//  SearchVC.swift
//  CreateApp
//
//  Created by Sonnv on 2/13/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    var keyWord     = String()
    var searchArray = [EventsPopular]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customSearchBar()
        
//        getGenericData(urlString: URLString.urlSearch) { (json: PopularAPI) in
//            guard let searchEvents = json.response?.events else { return }
//            DispatchQueue.main.async {
//                self.searchArray = searchEvents
//                self.tableView.reloadData()
//            }
//        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func customSearchBar() {
        searchBar.layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 1, alpha: 1)
        searchBar.layer.borderWidth = 13
        searchBar.clipsToBounds = true
        searchBar.layer.cornerRadius = 10
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.lableName.text           = searchArray[indexPath.row].name
        cell.startDateLable.text      = searchArray[indexPath.row].schedule_start_date
        cell.descriptionRawLable.text = searchArray[indexPath.row].description_raw?.htmlToString
        let urlImageArray             = searchArray[indexPath.row].photo
        cell.imgeView.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "InforPopularVC") as! InforPopularVC
        screen.textName           = searchArray[indexPath.row].name ?? ""
        screen.textNameVenue      = searchArray[indexPath.row].venue?.name ?? ""
        screen.textStartDate      = searchArray[indexPath.row].schedule_start_date ?? ""
        screen.textDescriptionRaw = searchArray[indexPath.row].description_raw ?? ""
        let urlImageArray         = searchArray[indexPath.row].photo
        screen.urlPhotoString     = urlImageArray ?? ""
        screen.eventId = searchArray[indexPath.row].id
        present(screen, animated: true, completion: nil)
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        keyWord = searchBar.text ?? ""
        getGenericData(urlString: URLString.urlSearch + "?pageIndex=1&pageSize=10&keyword=\(keyWord)") { (json: PopularAPI) in
            guard let searchEvents = json.response?.events else { return }
            DispatchQueue.main.async {
                self.searchArray = searchEvents
                self.tableView.reloadData()
            }
        }
    }
}

