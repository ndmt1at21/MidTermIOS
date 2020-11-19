//
//  GuessWelcomeViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit

class GuessViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initBtn(_ btn: UIButton!) {
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor("#0000ff", 1).cgColor
        btn.layer.borderWidth = 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
