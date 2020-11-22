//
//  TableRecordCell.swift
//  MidTerm
//
//  Created by Minh Tri on 11/22/20.
//

import UIKit

class GuestTableRecordCell: UITableViewCell {

    @IBOutlet weak var parentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var label1WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var label2WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var label3WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var label4WidthConstraint: NSLayoutConstraint!
    var labels: [UILabel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        parentViewHeightConstraint.constant = self.bounds.height
        
        // Set ratio & cal width each column
        let ratioColumn = [5, 2, 2, 2]
        let sumRatio: Int = ratioColumn.reduce(0) { (sum, curr) -> Int in
            sum + curr
        }
        let widthColumns: [CGFloat] = ratioColumn.map { (ratio) -> CGFloat in
            self.bounds.width / CGFloat(sumRatio) * CGFloat(ratio)
        }

        label1WidthConstraint.constant = widthColumns[0]
        label2WidthConstraint.constant = widthColumns[1]
        label3WidthConstraint.constant = widthColumns[2]
        label4WidthConstraint.constant = widthColumns[3]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
