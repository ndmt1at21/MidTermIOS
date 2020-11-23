//
//  SearchResultViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/20/20.
//

import UIKit
import RealmSwift

class GuestSearchResultViewController: UIViewController {

    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var lastNameCharSelected: String = ""
    var searchData: [GuestInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (font, userColor) = getUserSetting()
    
        searchTitleLabel.font = font.withSize(font.pointSize + 20)
        searchTitleLabel.textColor = userColor
        
        let nib = UINib(nibName: "SearchNameResultCell", bundle: .main)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: "ReuseableSearchNameResultCell")
        
        getGuestData()
    }
    
    func getGuestData() {
        let realm = try! Realm()
        
        print(lastNameCharSelected)
        if let guests = realm.objects(EventShow.self).first?.guests {
            print(guests)
            let guestsWithLastNameSelected = Array(guests).filter{
                $0.lastName.contains(lastNameCharSelected)
            }
            searchData = guestsWithLastNameSelected
            print(searchData)
            tableView.reloadData()
        }
        
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let des = segue.destination as? GuestDetailViewController {
            if let guest = sender as? GuestInfo {
                des.guestData = guest
            }
        }
    }
}

extension GuestSearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guest = searchData[indexPath.row]
        performSegue(withIdentifier: "SearchResultToDetail", sender: guest)
    }
}

extension GuestSearchResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseableSearchNameResultCell", for: indexPath) as! SearchNameResultCell
        
        if indexPath.row % 2 == 1 {
            cell.nameLabel.textColor = UIColor.black
        } else {
            cell.nameLabel.textColor = searchTitleLabel.textColor
        }
        cell.nameLabel.font = searchTitleLabel.font.withSize(searchTitleLabel.font.pointSize + 30)
        
        let guest = searchData[indexPath.row]
        cell.nameLabel.text =  guest.firstName + ", " + guest.lastName
        
        return cell
    }
}
