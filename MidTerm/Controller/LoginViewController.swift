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
    @IBOutlet weak var loginStatusLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    let userManager = UserManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        userManager.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        usernameTextField.cornerRadiusAndShadow()
        passwordTextField.cornerRadiusAndShadow()
        loginButton.layer.cornerRadius = loginButton.frame.height / 4
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        userManager.fetchUser(
            user: usernameTextField.text ?? "",
            pass: passwordTextField.text ?? ""
        )
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

extension LoginViewController: UserDelegate {
    func didSignInSuccess(_ userManager: UserManager) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "LoginToWelcome", sender: self)
        }
    }
    
    func didSignInFailed(_ userManager: UserManager, error: String) {
        DispatchQueue.main.async {
            self.loginStatusLabel.text = error
        }
    }
}
