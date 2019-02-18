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
//    var eventsArray  = [EventsPopular]()
    var searchArray = [Events]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGenericData(urlString: URLString.urlSearch) { (json: SearchAPI) in
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
        cell.lableNameVenue.text = searchArray[indexPath.row].venue?.name
        cell.lableDescription.text = searchArray[indexPath.row].venue?.description
        let urlImageArray = searchArray[indexPath.row].photo
        cell.imgeView.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
    
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let screen = storyboard.instantiateViewController(withIdentifier: "InforPopular") as! InforPopularVC
//        screen.textRaw = searchArray[indexPath.row].description_raw ?? ""
//        screen.textHTML = searchArray[indexPath.row].description_html ?? ""
        screen.textStartTime = searchArray[indexPath.row].schedule_start_time ?? ""
        screen.textEndTime = searchArray[indexPath.row].schedule_end_time ?? ""
        screen.textStartDate = searchArray[indexPath.row].schedule_start_date ?? ""
        screen.textEndDate = searchArray[indexPath.row].schedule_end_date ?? ""
        navigationController?.pushViewController(screen, animated: true)
    }
}

extension SearchVC:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        keyWord = searchBar.text ?? ""
        
        getGenericData(urlString: URLString.urlSearch + "?pageIndex=1&pageSize=10&keyword=\(keyWord)") { (json: SearchAPI) in
            guard let searchEvents = json.response?.events else { return }
            self.searchArray = searchEvents
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

