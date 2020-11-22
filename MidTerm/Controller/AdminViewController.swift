//
//  AdminViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit
import SCLAlertView

class AdminViewController: UIViewController {

    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupBtnUI(createButton)
        setupBtnUI(editButton)
    }
    
    private func setupBtnUI(_ btn: UIButton!) {
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor("#0000ff", 1).cgColor
        btn.layer.borderWidth = 1
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        let apperance = SCLAlertView.SCLAppearance(
            kTextFont: UIFont.systemFont(ofSize: 20),
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: apperance)
        alert.addButton("OK", action: {
            self.performSegue(withIdentifier: "AdminToCreateEvent", sender: self)
        })
        alert.addButton("Cancel", action: {/* Do nothing */})
        alert.showWarning("", subTitle: "Creating new event will delete all the info from the previous or current event in the app")
    }

    @IBAction func editButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
