//
//  CreateEventViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit
import RealmSwift

class CreateEventViewController: UIViewController {
    
    @IBOutlet weak var pickerColor: ColorPicker!
    @IBOutlet weak var pickerFont: FontPicker!
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tableRecord: TableRecord!
    
    var tableRecordHeader: [String] = ["Name", "Guest", "Table", "Section"]
    var tableData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delte all in database ----
        pickerFont.delegate = self
        pickerColor.delegate = self
        tableRecord.delegate = self
        tableRecord.datasource = self
        
        tableRecord.showTableRecord()
        let nib = UINib(nibName: "TableRecordCell", bundle: .main)
        tableRecord.register(
            nib: nib,
            forCellWithReuseIdentifier: "ReuseableTableRecordCell"
        )
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
        tableData = []
        
        let realm = try! Realm()
        let guests = realm.objects(GuestInfo.self)
        guests.forEach { (guest) in
            let guestValues: [String] = [
                guest.firstName + ", " + guest.lastName,
                String(guest.nGuest),
                guest.tableID,
                guest.sectionID
            ]
            tableData.append(contentsOf: guestValues)
        }
        
        DispatchQueue.main.async {
            self.tableRecord.reloadData()
        }
    }
}

extension CreateEventViewController: TableRecordDelegate {
    func ratioBetweenColumns(_ tableRecord: TableRecord) -> [Float] {
        return [5, 2, 2, 2]
    }
}

extension CreateEventViewController: TableRecordDataSource {
    func tableRecord(_ tableRecord: TableRecord, cellForItemAt coord: CellCoord) -> UICollectionViewCell {
        let cell = tableRecord.dequeueReusableCell(
            withReuseIdentifier: "ReuseableTableRecordCell",
            for: coord
        ) as! TableRecordCell
        
        cell.textLabel.text = tableData[coord.row * 4 + coord.col]
        return cell
    }
    
    func tableRecord(_ tableRecord: TableRecord, cellForHeaderAt column: Int) -> UICollectionViewCell {
        let cell = tableRecord.dequeueReusableCell(
            withReuseIdentifier: "ReuseableTableRecordCell",
            for: CellCoord(col: column, row: 0)
        ) as! TableRecordCell
        
        cell.textLabel.text = tableRecordHeader[column]
        cell.textLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return cell
    }
    
    func numberItems(_ tableRecord: TableRecord) -> Int {
        print(tableData)
        return tableData.count
    }
    
    func numberOfColumns(_ tableRecord: TableRecord) -> Int {
        return 4
    }
}
