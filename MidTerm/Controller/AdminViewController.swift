//
//  AdminViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit
import SCLAlertView

class AdminViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        alert.addButton("Cancel", action: {})
        alert.showWarning("", subTitle: "Creating new event will delete all the info from the previous or current event in the app")
    }
    
    func okButtonPressed() {
        
    }
    

    @IBAction func editButtonPressed(_ sender: UIButton) {
    }
}
