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

    var searchData: [GuestInfo] = []
    var delegate: GuestLastNameViewDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (font, userColor) = getUserSetting()
        UILabel.appearance().font = font
        UILabel.appearance().textColor = userColor
        UIButton.appearance().titleLabel?.font = font
        UIButton.appearance().tintColor = userColor
        UIButton.appearance().setTitleColor(userColor, for: .normal)
    
        searchTitleLabel.font = font.withSize(font.pointSize + 20)
        
        let nib = UINib(nibName: "SearchNameResultCell", bundle: .main)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: "ReuseableSearchNameResultCell")
    }

    @IBAction func homeButtonPressed(_ sender: Any) {
        let vc = GuessWelcomeViewController()
        navigationController?.popToViewController(vc, animated: true)
    }
}

extension GuestSearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
            cell.nameLabel.textColor = UILabel.appearance().textColor
        }
        cell.nameLabel.font = UILabel.appearance().font.withSize(
            UILabel.appearance().font.pointSize + 30
        )
        
        let guest = searchData[indexPath.row]
        cell.nameLabel.text =  guest.firstName + ", " + guest.lastName
        
        return cell
    }
}

extension GuestSearchResultViewController: GuestLastNameViewDelegate {
    func guessLastNameView(_ guessLastNameViewController: GuestLastNameViewController, lastNameCharSelected: String) {
        let realm = try! Realm()
        
        if let guests = realm.objects(EventShow.self).first?.guests {
            print(guests)
            let guestsWithLastNameSelected = Array(guests).filter{
                $0.lastName.contains(lastNameCharSelected)
            }
            searchData = guestsWithLastNameSelected
            tableView.reloadData()
        }
    }
}
