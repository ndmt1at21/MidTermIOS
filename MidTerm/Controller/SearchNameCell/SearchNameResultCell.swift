//
//  NameResultCell.swift
//  MidTerm
//
//  Created by Minh Tri on 11/22/20.
//

import UIKit

class SearchNameResultCell: UITableViewCell {

    @IBOutlet weak var lineWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        lineWidthConstraint.constant = self.bounds.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
