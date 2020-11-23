//
//  CreateEventViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit
import RealmSwift

class CreateEventViewController: UIViewController {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var pickerColor: ColorPicker!
    @IBOutlet weak var pickerFont: FontPicker!
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var guestTableRecord: GuestTableRecord!
    
    let eventShow = EventShow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delte all in database ----
        pickerFont.delegate = self
        pickerColor.delegate = self
        guestTableRecord.dataSource = self

        guestTableRecord.showTableRecord()
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(EventShow.self))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Calculate position pickerFont will appear
        // to: nil -> convert to coord windows
        let pointFontLabel = fontLabel.superview?.convert(fontLabel.frame.origin, to: nil)
        pickerFont.frame = CGRect(
            x: pointFontLabel!.x,
            y: pointFontLabel!.y + 20,
            width: 400,
            height: 300
        )
        
        // Calculate position pickerColor will appear
        let pointColorLabel = colorLabel.superview?.convert(colorLabel.frame.origin, to: nil)
        pickerColor.frame = CGRect(
            x: pointColorLabel!.x,
            y: pointColorLabel!.y + 20,
            width: 400,
            height: 400
        )
    }

    @IBAction func buttonFontPressed(_ sender: UIButton) {
        pickerFont.isHidden = !pickerFont.isHidden
        pickerFont.showPicker()
    }
    
    @IBAction func buttonPickColorPressed(_ sender: UIButton) {
        pickerColor.isHidden = !pickerColor.isHidden
        pickerColor.showPicker()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        fontSizeLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "CreateEventToAddGuest", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let des = segue.destination as? AddGuestViewController {
            des.delegate = self
        }
    }
    
    @IBAction func buttonSavePressed(_ sender: UIButton) {
        UserDefaults.standard.set(slider.value, forKey: "UserFontSize")
        UserDefaults.standard.set(fontLabel.text, forKey: "UserFontName")
        UserDefaults.standard.set(colorLabel.backgroundColor, forKey: "UserColor")
        
        if eventNameTextField.text?.trimmingCharacters(in: .whitespaces).count == 0 {
            alertError(title: "Error", message: "Event Name cannot empty", toFocus: eventNameTextField, vc: self)
            return
        } else if eventShow.guests.count == 0 {
            alertError(title: "Error", message: "Avent >= 1 guest", toFocus: nil, vc: self)
            return
        }
        
        eventShow.eventName = eventNameTextField.text!
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(eventShow)
        }
    }
    
    @IBAction func buttonExitPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - FontPickerDelegate
extension CreateEventViewController: FontPickerDelegate {
    func didButtonOKPressed(font: String) {
        pickerFont.isHidden = true
        fontLabel.text = font
        fontLabel.font = UIFont(name: font, size: fontLabel.font.pointSize)
    }
    
    func didButtonCancelPressed(font: String) {
        pickerFont.isHidden = true
    }
}

// MARK: - ColorPickerDelegate
extension CreateEventViewController: ColorPickerDelegate {
    func colorPicker(colorSelected: UIColor) {
        colorLabel.backgroundColor = colorSelected
    }
}

// MARK: - AddGuestViewDelegate (get data when added guest infor)
extension CreateEventViewController: AddGuestViewDelegate {
    func didSavePressed(_ addGuestVC: AddGuestViewController, guestInfo: GuestInfo) {
        guestInfo.id = eventShow.guests.count
        eventShow.guests.append(guestInfo)
        guestTableRecord.reloadData()
    }
}

extension CreateEventViewController: GuestTableRecordDataSource {
    func guestTableRecord(_ guestTableRecord: GuestTableRecord, guestForRow row: Int) -> GuestInfo {
        return eventShow.guests[row]
    }
    
    func numberOfRows(_ guestTableRecord: GuestTableRecord) -> Int {
        return eventShow.guests.count
    }
}
