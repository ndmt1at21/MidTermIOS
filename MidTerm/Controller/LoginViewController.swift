//
//  LoginViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.cornerRadiusAndShadow()
        passwordTextField.cornerRadiusAndShadow()
        loginButton.layer.cornerRadius = loginButton.frame.height / 4;
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
}