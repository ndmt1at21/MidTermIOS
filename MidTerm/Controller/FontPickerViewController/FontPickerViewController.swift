//
//  PickerFont.swift
//  MidTerm
//
//  Created by Minh Tri on 11/18/20.
//

import UIKit

protocol FontPickerDelegate: UIPickerViewDelegate {
    func didButtonOKPressed(font: String);
    func didButtonCancelPressed(font: String);
}

@IBDesignable
class FontPicker: UIView {

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cancelLabel: UIButton!
    @IBOutlet weak var okLabel: UIButton!
    
    var delegate: FontPickerDelegate?
    var allFonts: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configPicker() {
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // Get data
        allFonts = getFontData()
        pickerView.reloadAllComponents()
        
        // SetupUI
        pickerView.backgroundColor = UIColor("#eeeeee", 1)
        parentView.layer.cornerRadius = 20
        pickerView.layer.cornerRadius = 20
        parentView.layer.shadow(0, 0, 15, UIColor("#000", 0.3).cgColor)
    }
    
    func showPicker() {
        if self.subviews.isEmpty {
            guard let view = self.loadViewFromNib(nibName: K.nibName.fontPicker) else {
                return
            }
            
            configPicker()
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    @IBAction func buttonOKPressed(_ sender: UIButton) {
        let row = pickerView.selectedRow(inComponent: 0)
        delegate?.didButtonOKPressed(font: allFonts[row])
    }
    
    @IBAction func buttonCancelPressed(_ sender: UIButton) {
        let row = pickerView.selectedRow(inComponent: 0)
        delegate?.didButtonCancelPressed(font: allFonts[row])
    }
}

extension FontPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.text = allFonts[row]
        label.font = UIFont(name: allFonts[row], size: 25)
        label.textAlignment = .center
        
        return label
    }
}

// MARK: - Get All Font Names
func getFontData() -> [String] {
    let fontFamilies = UIFont.familyNames
    var fonts: [String] = []
    
    fontFamilies.forEach { fontFamily in
        fonts += UIFont.fontNames(forFamilyName: fontFamily)
    }
    return fonts
}

// MARK: - Picker Data Source
extension FontPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allFonts.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allFonts[row]
    }
}
