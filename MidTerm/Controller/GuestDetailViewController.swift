//
//  GuestDetailViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/20/20.
//

import UIKit
import RealmSwift

class GuestDetailViewController: UIViewController {
    
    @IBOutlet weak var nameGuestLabel: UILabel!
    @IBOutlet weak var tableNumberLabel: UILabel!
    @IBOutlet weak var guestNumberLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    
    @IBOutlet weak var guestTableNumberLabel: UILabel!
    @IBOutlet weak var guestNumberGuestLabel: UILabel!
    @IBOutlet weak var guestSectionLabel: UILabel!
    
    @IBOutlet weak var whoseLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var guestData = GuestInfo()
    var guestsInSameTable: [GuestInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (font, userColor) = getUserSetting()
        let normalSize: CGFloat = font.pointSize
        
        nameGuestLabel.font = font.withSize(normalSize + 50)
        tableNumberLabel.font = font.withSize(normalSize + 30)
        guestNumberLabel.font = guestNumberLabel.font
        sectionLabel.font = guestNumberLabel.font
       
        nameGuestLabel.textColor = userColor
        tableNumberLabel.textColor = userColor
        guestNumberLabel.textColor = userColor
        sectionLabel.textColor = userColor
        
        guestTableNumberLabel.font = font.withSize(normalSize + 70)
        guestNumberGuestLabel.font = nameGuestLabel.font
        guestSectionLabel.font = nameGuestLabel.font
        
        guestTableNumberLabel.layer.cornerRadius = guestTableNumberLabel.bounds.height / 2
        guestTableNumberLabel.layer.masksToBounds = true
        whoseLabel.font = font.withSize(normalSize + 20)
        whoseLabel.textColor = userColor
        
        nameGuestLabel.text = guestData.firstName + ", " + guestData.lastName
        guestTableNumberLabel.text = guestData.tableID
        guestNumberGuestLabel.text = String(guestData.nGuest)
        guestSectionLabel.text = guestData.sectionID
        
        tableView.dataSource = self
        tableView.delegate = self
        getGuestsInSameTableData()
        
        // Not call register when add cell view in storyboard
    }
    
    func getGuestsInSameTableData() {
        let realm = try! Realm()
        if let guests = realm.objects(EventShow.self).first?.guests {
            let sameTable = Array(guests).filter{
                $0.tableID == guestData.tableID
            }
            guestsInSameTable = sameTable
            tableView.reloadData()
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension GuestDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension GuestDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestsInSameTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseCellID.whoseSameTable, for: indexPath) as! WhoseSameTableCell
        
        let guest = guestsInSameTable[indexPath.row]
        
        cell.nameLabel.text = guest.firstName + ", " + guest.lastName
        cell.numberGuestLabel.text = String(guest.nGuest)
        cell.nameLabel.font = UIFont.systemFont(ofSize: 20)
        cell.numberGuestLabel.font = UIFont.systemFont(ofSize: 20)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor("#a1daff", 1)
        } else {
            cell.backgroundColor = UIColor("#cfecff", 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseCellID.whoseSameTable) as! WhoseSameTableCell
        
        let headerTable = ["Guest Names", "Guests"]
        cell.nameLabel.text = headerTable[0]
        cell.numberGuestLabel.text = headerTable[1]
        
        cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cell.numberGuestLabel.font = cell.nameLabel.font
        
        cell.nameLabel.textColor = UIColor.white
        cell.numberGuestLabel.textColor = UIColor.white
        
        cell.backgroundColor = UIColor("#1F97E7", 1)
        return cell
    }
}
