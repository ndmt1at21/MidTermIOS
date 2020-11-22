//
//  SearchResultViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/20/20.
//

import UIKit

class SearchResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func homeButtonPressed(_ sender: Any) {
        let vc = GuessWelcomeViewController()
        navigationController?.popToViewController(vc, animated: true)
    }
}
