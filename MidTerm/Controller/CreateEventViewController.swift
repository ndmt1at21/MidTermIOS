//
//  CreateEventViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    @IBOutlet weak var pickerColor: ColorPicker!
    @IBOutlet weak var pickerFont: FontPicker!
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerFont.delegate = self
        pickerColor.delegate = self
    }

    @IBAction func buttonFontPressed(_ sender: UIButton) {
        pickerFont.isHidden = !pickerFont.isHidden
        let pointFontLabel = fontLabel.superview?.convert(fontLabel.frame.origin, to: nil)
        pickerFont.frame = CGRect(
            x: pointFontLabel!.x,
            y: pointFontLabel!.y + 20,
            width: 400,
            height: 300
        )
        pickerFont.showPicker()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        fontSizeLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func buttonPickColorPressed(_ sender: UIButton) {
        pickerColor.isHidden = !pickerColor.isHidden
        let pointFontLabel = colorLabel.superview?.convert(fontLabel.frame.origin, to: nil)
        pickerColor.frame = CGRect(
            x: pointFontLabel!.x,
            y: pointFontLabel!.y + 50,
            width: 400,
            height: 400
        )
        pickerColor.showPicker()
    }
}

extension CreateEventViewController: FontPickerDelegate {
    func didButtonOKPressed(font: String) {
        fontLabel.text = font
        pickerFont.isHidden = true
    }
    
    func didButtonCancelPressed(font: String) {
        pickerFont.isHidden = true
    }
}

extension CreateEventViewController: ColorPickerDelegate {
    func colorPicker(colorSelected: UIColor) {
        colorLabel.backgroundColor = colorSelected
        colorLabel.text = ""
    }
}
