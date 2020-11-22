//
//  TableRecordCell.swift
//  MidTerm
//
//  Created by Minh Tri on 11/22/20.
//

import UIKit

class GuestTableRecordCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UIView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    var labels: [UILabel] = []
    let heightCell = 100
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set ratio & cal width each column
        let ratioColumn = [5, 2, 2, 2]
        let sumRatio: Int = ratioColumn.reduce(0) { (sum, curr) -> Int in
            sum + curr
        }
        let widthColumns: [Int] = ratioColumn.map { (ratio) -> Int in
            Int(self.bounds.width) / sumRatio * ratio
        }
        
        // Cal position
        var xCurrent = 0
        var rects: [CGRect] = []
        for i in 1...ratioColumn.count {
            let rect = CGRect(
                x: xCurrent,
                y: 0,
                width: widthColumns[i],
                height: heightCell
            )
            xCurrent += widthColumns[i]
            rects.append(rect)
        }
        
        label1.frame = rects[0]
        label2.frame = rects[1]
        label3.frame = rects[2]
        label4.frame = rects[3]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
