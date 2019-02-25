//
//  SearchVC.swift
//  CreateApp
//
//  Created by Sonnv on 2/13/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    var keyWord = ""
    var searchArray = [EventsPopular]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGenericData(urlString: URLString.urlSearch) { (json: PopularAPI) in
            guard let searchEvents = json.response?.events else { return }
            self.searchArray = searchEvents
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.lableName.text = searchArray[indexPath.row].name
        cell.startDateLable.text = searchArray[indexPath.row].schedule_start_date
        cell.descriptionRawLable.text = searchArray[indexPath.row].description_raw?.htmlToString
        let urlImageArray = searchArray[indexPath.row].photo
        cell.imgeView.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
    
}

extension SearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "InforPopular") as! InforPopularVC
        screen.textName = searchArray[indexPath.row].name ?? ""
        screen.textNameVenue = searchArray[indexPath.row].venue?.name ?? ""
        screen.textStartDate = searchArray[indexPath.row].schedule_start_date ?? ""
        screen.textDescriptionRaw = searchArray[indexPath.row].description_raw ?? ""
        let urlImageArray = searchArray[indexPath.row].photo
        screen.urlPhotoString = urlImageArray ?? ""
        navigationController?.pushViewController(screen, animated: true)
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        keyWord = searchBar.text ?? ""

        getGenericData(urlString: URLString.urlSearch + "?pageIndex=1&pageSize=10&keyword=\(keyWord)") { (json: PopularAPI) in
            guard let searchEvents = json.response?.events else { return }
            self.searchArray = searchEvents
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

