//
//  TableRecord.swift
//  MidTerm
//
//  Created by Minh Tri on 11/22/20.
//

import UIKit
import RealmSwift

protocol GuestTableRecordDataSource {
    func guestTableRecord(_ guestTableRecord: GuestTableRecord, guestForRow row: Int) -> GuestInfo;
    func numberOfRows(_ guestTableRecord: GuestTableRecord) -> Int;
}

class GuestTableRecord: UIView {
    
    @IBOutlet weak var tableView: UITableView!
   
    var guestTableHeader = ["Name", "Guests", "Table", "Section"]
    let rowHeight: CGFloat = 50
    var dataSource: GuestTableRecordDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configTableRecord() {
        let nib = UINib(nibName: K.nibName.guestTableRecordCell, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: K.reuseCellID.guestTableRecord)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showTableRecord() {
        if self.subviews.isEmpty {
            guard let view = loadViewFromNib(nibName: K.nibName.guestTableRecord) else {
                return
            }
            configTableRecord()
            
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension GuestTableRecord: UITableViewDelegate {
    
}

extension GuestTableRecord: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfRows(self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseCellID.guestTableRecord, for: indexPath) as! GuestTableRecordCell
        
        if let guest = dataSource?.guestTableRecord(self, guestForRow: indexPath.row) {
            cell.label1.text = guest.firstName + ", " + guest.lastName
            cell.label2.text = String(guest.nGuest)
            cell.label3.text = guest.tableID
            cell.label4.text = guest.sectionID
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseCellID.guestTableRecord) as! GuestTableRecordCell
        
        cell.label1.text = guestTableHeader[0]
        cell.label2.text = guestTableHeader[1]
        cell.label3.text = guestTableHeader[2]
        cell.label4.text = guestTableHeader[3]
        
        cell.label1.font = UIFont.boldSystemFont(ofSize: 20)
        cell.label2.font = UIFont.boldSystemFont(ofSize: 20)
        cell.label3.font = UIFont.boldSystemFont(ofSize: 20)
        cell.label4.font = UIFont.boldSystemFont(ofSize: 20)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return rowHeight
    }
}
