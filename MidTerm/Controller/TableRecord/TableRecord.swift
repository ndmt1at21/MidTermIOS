//
//  TableRecord.swift
//  MidTerm
//
//  Created by Minh Tri on 11/22/20.
//

import UIKit

class GuestTableRecord: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configTableRecord() {
        let nib = UINib(nibName: "TableRecordCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "ReuseableTableRecordCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showTableRecord() {
        if self.subviews.isEmpty {
            guard let view = loadViewFromNib(nibName: "TableRecord") else {
                return
            }
            configTableRecord()
            
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}

extension GuestTableRecord: UITableViewDelegate {
    
}

extension GuestTableRecord: UITableViewDataSource {
    
}
