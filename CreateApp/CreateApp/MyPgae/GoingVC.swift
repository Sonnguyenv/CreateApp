//
//  ListEventWillGoVC.swift
//  CreateApp
//
//  Created by Sonnv on 2/20/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import UIKit

class GoingVC: UIViewController {

    let keyChain = KeychainSwift()
    @IBOutlet weak var myTable: UITableView!
    var eventsArray = [EventsPopular]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "TableViewCell", bundle: nil)
        myTable.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        guard let token = keyChain.get("token") else {return}
        getGenericData(urlString: URLString.urlListMyEvents + "?status=1&token=\(token)") { (json: PopularAPI) in
            guard let events = json.response?.events else {return}
            DispatchQueue.main.async {
                self.eventsArray = events
                self.myTable.reloadData()
            }
        }
    }
}

extension GoingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "TableViewCell") as! TableViewCell
        cell.titleLable.text       = eventsArray[indexPath.row].name
        cell.descriptionLable.text = eventsArray[indexPath.row].description_raw?.htmlToString
        cell.startDateLable.text   = eventsArray[indexPath.row].schedule_start_date
        //MARK: Cache Image
        let urlImageArray          = eventsArray[indexPath.row].photo
        cell.imagView.cacheImage(urlString: urlImageArray ?? "")
        return cell
    }
}

extension GoingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InforPopularVC") as! InforPopularVC
        scr.textName           = eventsArray[indexPath.row].name ?? ""
        scr.textNameVenue      = eventsArray[indexPath.row].venue?.name ?? ""
        scr.textStartDate      = eventsArray[indexPath.row].schedule_start_date ?? ""
        scr.textDescriptionRaw = eventsArray[indexPath.row].description_raw ?? ""
        scr.eventId            = eventsArray[indexPath.row].id
        //MARK: Cache Image
        let urlImageArray    = eventsArray[indexPath.row].photo
        scr.urlPhotoString   = urlImageArray ?? ""
        scr.eventsArrayInfor = eventsArray
        present(scr, animated: true, completion: nil)
    }
}
