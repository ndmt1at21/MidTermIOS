//
//  ColorPicker.swift
//  MidTerm
//
//  Created by Minh Tri on 11/19/20.
//

import UIKit

protocol ColorPickerDelegate {
    func colorPicker(colorSelected: UIColor);
}

class ColorPicker: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var parentView: UIView!
    var colors: [UIColor] = []
    var delegate: ColorPickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configPicker() {
        // Load reuseable cell
        let nib = UINib(nibName: K.nibName.colorPickerCell, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: K.reuseCellID.colorPicker)
        
        // Assign delegate & datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        colors = getColorData()
        
        // Setup UI
        parentView.layer.cornerRadius = 20
        parentView.backgroundColor = UIColor("#eeeeee", 1)
        parentView.layer.shadow(0, 0, 15, UIColor("#000", 0.3).cgColor)
        
        collectionView.backgroundColor = UIColor("#eeeeee", 1)
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    func showPicker() {
        if self.subviews.isEmpty {
            guard let view = loadViewFromNib(nibName: K.nibName.colorPicker) else {
                return
            }
            configPicker()
            
            // Why not set = self.frame (self.frame can be [50, 50, 100, 200]
            // Just get current width height
            view.frame = self.bounds
            
            // Add subview to view controller
            self.addSubview(view)
        }
        
    }
    
    @IBAction func buttonClosePressed(_ sender: UIButton) {
        self.isHidden = true
    }
    
    func getColorData() -> [UIColor] {
        colors = [
            UIColor("#EEEEEE", 1),    UIColor("#DDDDDD", 1),    UIColor("#CCCCCC", 1),
            UIColor("#BBBBBB", 1),    UIColor("#AAAAAA", 1),    UIColor("#999999", 1),
            UIColor("#888888", 1),    UIColor("#777777", 1),    UIColor("#666666", 1),
            UIColor("#555555", 1),    UIColor("#444444", 1),    UIColor("#333333", 1),
            UIColor("#222222", 1),    UIColor("#111111", 1),    UIColor("#000000", 1),
            UIColor("#FF0000", 1),    UIColor("#EE0000", 1),    UIColor("#DD0000", 1),
            UIColor("#CC0000", 1),    UIColor("#BB0000", 1),    UIColor("#AA0000", 1),
            UIColor("#990000", 1),    UIColor("#880000", 1),    UIColor("#770000", 1),
            UIColor("#660000", 1),    UIColor("#550000", 1),    UIColor("#440000", 1),
            UIColor("#330000", 1),    UIColor("#220000", 1),    UIColor("#110000", 1),
            UIColor("#FFFFFF", 1),    UIColor("#FFFFCC", 1),    UIColor("#FFFF99", 1),
            UIColor("#FFFF66", 1),    UIColor("#FFFF33", 1),    UIColor("#FFFF00", 1),
            UIColor("#CCFFFF", 1),    UIColor("#CCFFCC", 1),    UIColor("#CCFF99", 1),
            UIColor("#CCFF66", 1),    UIColor("#CCFF33", 1),    UIColor("#CCFF00", 1),
            UIColor("#99FFFF", 1),    UIColor("#99FFCC", 1),    UIColor("#99FF99", 1),
            UIColor("#99FF66", 1),    UIColor("#99FF33", 1),    UIColor("#99FF00", 1),
            UIColor("#66FFFF", 1),    UIColor("#66FFCC", 1),    UIColor("#66FF99", 1),
            UIColor("#66FF66", 1),    UIColor("#66FF33", 1),    UIColor("#66FF00", 1),
            UIColor("#33FFFF", 1),    UIColor("#33FFCC", 1),    UIColor("#33FF99", 1),
            UIColor("#33FF66", 1),    UIColor("#33FF33", 1),    UIColor("#33FF00", 1),
            UIColor("#00FFFF", 1),    UIColor("#00FFCC", 1),    UIColor("#00FF99", 1),
            UIColor("#00FF66", 1),    UIColor("#00FF33", 1),    UIColor("#00FF00", 1),
            UIColor("#FFCCFF", 1),    UIColor("#FFCCCC", 1),    UIColor("#FFCC99", 1),
            UIColor("#FFCC66", 1),    UIColor("#FFCC33", 1),    UIColor("#FFCC00", 1),
            UIColor("#CCCCFF", 1),    UIColor("#CCCCCC", 1),    UIColor("#CCCC99", 1),
            UIColor("#CCCC66", 1),    UIColor("#CCCC33", 1),    UIColor("#CCCC00", 1),
            UIColor("#99CCFF", 1),    UIColor("#99CCCC", 1),    UIColor("#99CC99", 1),
            UIColor("#99CC66", 1),    UIColor("#99CC33", 1),    UIColor("#99CC00", 1),
            UIColor("#66CCFF", 1),    UIColor("#66CCCC", 1),    UIColor("#66CC99", 1),
            UIColor("#66CC66", 1),    UIColor("#66CC33", 1),    UIColor("#66CC00", 1),
            UIColor("#33CCFF", 1),    UIColor("#33CCCC", 1),    UIColor("#33CC99", 1),
            UIColor("#33CC66", 1),    UIColor("#33CC33", 1),    UIColor("#33CC00", 1),
            UIColor("#00CCFF", 1),    UIColor("#00CCCC", 1),    UIColor("#33CC66", 1),
            UIColor("#33CC33", 1),    UIColor("#00CC99", 1),    UIColor("#00CC66", 1),
            UIColor("#00CC33", 1),    UIColor("#00CC00", 1),    UIColor("#FF99FF", 1),
            UIColor("#FF99CC", 1),    UIColor("#FF9999", 1),    UIColor("#FF9966", 1),
            UIColor("#FF9933", 1),    UIColor("#FF9900", 1),    UIColor("#CC99FF", 1),
            UIColor("#CC99CC", 1),    UIColor("#CC9999", 1),    UIColor("#CC9966", 1),
            UIColor("#CC9933", 1),    UIColor("#CC9900", 1),    UIColor("#9999FF", 1),
            UIColor("#9999CC", 1),    UIColor("#999999", 1),    UIColor("#999966", 1),
            UIColor("#999933", 1),    UIColor("#999900", 1),    UIColor("#6699FF", 1),
            UIColor("#6699CC", 1),    UIColor("#669999", 1),    UIColor("#669966", 1),
            UIColor("#669933", 1),    UIColor("#669900", 1),    UIColor("#3399FF", 1),
            UIColor("#3399CC", 1),    UIColor("#339999", 1),    UIColor("#339966", 1),
            UIColor("#339933", 1),    UIColor("#339900", 1),    UIColor("#0099FF", 1),
            UIColor("#0099CC", 1),    UIColor("#009999", 1),    UIColor("#009966", 1),
            UIColor("#009933", 1),    UIColor("#009900", 1),    UIColor("#FF66FF", 1),
            UIColor("#FF66CC", 1),    UIColor("#FF6699", 1),    UIColor("#FF6666", 1),
            UIColor("#FF6633", 1),    UIColor("#FF6600", 1),    UIColor("#CC66FF", 1),
            UIColor("#CC66CC", 1),    UIColor("#CC6699", 1),    UIColor("#CC6666", 1),
            UIColor("#CC6633", 1),    UIColor("#CC6600", 1),    UIColor("#9966FF", 1),
            UIColor("#9966CC", 1),    UIColor("#996699", 1),    UIColor("#996666", 1),
            UIColor("#996633", 1),    UIColor("#996600", 1),    UIColor("#6666FF", 1),
            UIColor("#6666CC", 1),    UIColor("#666699", 1),    UIColor("#666666", 1),
            UIColor("#666633", 1),    UIColor("#666600", 1),    UIColor("#3366FF", 1),
            UIColor("#3366CC", 1),    UIColor("#336699", 1),    UIColor("#336666", 1),
            UIColor("#336633", 1),    UIColor("#336600", 1),    UIColor("#0066FF", 1),
            UIColor("#0066CC", 1),    UIColor("#006699", 1),    UIColor("#006666", 1),
            UIColor("#006633", 1),    UIColor("#006600", 1),    UIColor("#FF33FF", 1),
            UIColor("#FF33CC", 1),    UIColor("#FF3399", 1),    UIColor("#FF3366", 1),
            UIColor("#FF3333", 1),    UIColor("#FF3300", 1),    UIColor("#CC33FF", 1),
            UIColor("#CC33CC", 1),    UIColor("#CC3399", 1),    UIColor("#CC3366", 1),
            UIColor("#CC3333", 1),    UIColor("#CC3300", 1),    UIColor("#9933FF", 1),
            UIColor("#9933CC", 1),    UIColor("#993399", 1),    UIColor("#993366", 1),
            UIColor("#993333", 1),    UIColor("#993300", 1),    UIColor("#6633FF", 1),
            UIColor("#6633CC", 1),    UIColor("#663399", 1),    UIColor("#663366", 1),
            UIColor("#663333", 1),    UIColor("#663300", 1),    UIColor("#3333FF", 1),
            UIColor("#3333CC", 1),    UIColor("#333399", 1),    UIColor("#333366", 1),
            UIColor("#333333", 1),    UIColor("#333300", 1),    UIColor("#0033FF", 1),
            UIColor("#FF3333", 1),    UIColor("#0033CC", 1),    UIColor("#003399", 1),
            UIColor("#003366", 1),    UIColor("#003333", 1),    UIColor("#003300", 1),
            UIColor("#FF00FF", 1),    UIColor("#FF00CC", 1),    UIColor("#FF0099", 1),
            UIColor("#FF0066", 1),    UIColor("#FF0033", 1),    UIColor("#FF0000", 1),
            UIColor("#CC00FF", 1),    UIColor("#CC00CC", 1),    UIColor("#CC0099", 1),
            UIColor("#CC0066", 1),    UIColor("#CC0033", 1),    UIColor("#CC0000", 1),
            UIColor("#9900FF", 1),    UIColor("#9900CC", 1),    UIColor("#990099", 1),
            UIColor("#990066", 1),    UIColor("#990033", 1),    UIColor("#990000", 1),
            UIColor("#6600FF", 1),    UIColor("#6600CC", 1),    UIColor("#660099", 1),
            UIColor("#660066", 1),    UIColor("#660033", 1),    UIColor("#660000", 1),
            UIColor("#3300FF", 1),    UIColor("#3300CC", 1),    UIColor("#330099", 1),
            UIColor("#330066", 1),    UIColor("#330033", 1),    UIColor("#330000", 1),
            UIColor("#0000FF", 1),    UIColor("#0000CC", 1),    UIColor("#000099", 1),
            UIColor("#000066", 1),    UIColor("#000033", 1),    UIColor("#00FF00", 1),
            UIColor("#00EE00", 1),    UIColor("#00DD00", 1),    UIColor("#00CC00", 1),
            UIColor("#00BB00", 1),    UIColor("#00AA00", 1),    UIColor("#009900", 1),
            UIColor("#008800", 1),    UIColor("#007700", 1),    UIColor("#006600", 1),
            UIColor("#005500", 1),    UIColor("#004400", 1),    UIColor("#003300", 1),
            UIColor("#002200", 1),    UIColor("#001100", 1),    UIColor("#0000FF", 1),
            UIColor("#0000EE", 1),    UIColor("#0000DD", 1),    UIColor("#0000CC", 1),
            UIColor("#0000BB", 1),    UIColor("#0000AA", 1),    UIColor("#000099", 1),
            UIColor("#000088", 1),    UIColor("#000077", 1),    UIColor("#000055", 1),
            UIColor("#000044", 1),    UIColor("#000022", 1),    UIColor("#000011", 1)
        ]
        return colors
    }
}

extension ColorPicker: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        delegate?.colorPicker(colorSelected: color)
    }
}

extension ColorPicker: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.reuseCellID.colorPicker, for: indexPath) as! ColorPickerCell
        cell.viewCell.backgroundColor = colors[indexPath.row]
        return cell
    }
}

extension ColorPicker: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
