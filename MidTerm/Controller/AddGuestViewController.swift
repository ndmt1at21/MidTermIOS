//
//  AddGuestViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/20/20.
//

import UIKit
import RealmSwift

protocol AddGuestViewDelegate {
    func didSavePressed(_ addGuestVC: AddGuestViewController, guestInfo: GuestInfo);
}

class AddGuestViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var guestTextField: UITextField!
    @IBOutlet weak var tableTextField: UITextField!
    @IBOutlet weak var sectionTextField: UITextField!
    
    var guestInfor = GuestInfo()
    var delegate: AddGuestViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        guestTextField.delegate = self
        tableTextField.delegate = self
        sectionTextField.delegate = self
        
        setupUI()
    }
    
    private func setupUI() {
        firstNameTextField.shadow(0, 0, 2, UIColor("#000", 0.2).cgColor)
        lastNameTextField.shadow(0, 0, 2, UIColor("#000", 0.2).cgColor)
        guestTextField.shadow(0, 0, 2, UIColor("#000", 0.2).cgColor)
        tableTextField.shadow(0, 0, 2, UIColor("#000", 0.2).cgColor)
        sectionTextField.shadow(0, 0, 2, UIColor("#000", 0.2).cgColor)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        checkForError(currentTextField: firstNameTextField)
        checkForError(currentTextField: lastNameTextField)
        checkForError(currentTextField: guestTextField)
        checkForError(currentTextField: tableTextField)
        checkForError(currentTextField: sectionTextField)
        
        guestInfor.firstName = firstNameTextField.text!
        guestInfor.lastName = lastNameTextField.text!
        guestInfor.nGuest = Int(guestTextField.text!) ?? 0
        guestInfor.tableID = tableTextField.text!
        guestInfor.sectionID = sectionTextField.text!
        
        delegate?.didSavePressed(self, guestInfo: guestInfor)
        print(Realm.Configuration.defaultConfiguration.fileURL)
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension AddGuestViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func checkForError(currentTextField: UITextField) {
        if let text = currentTextField.text {
            if text.trimmingCharacters(in: .whitespaces).count == 0 {
                alertError(
                    title: "Error",
                    message: "Information cannot empty",
                    toFocus: currentTextField,
                    vc: self
                )
            }
        }
    }
}
