//
//  GuessWelcomeViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit

class GuestWelcomeViewController: UIViewController {
    
    @IBOutlet weak var guessNameLabel: UILabel!
    @IBOutlet weak var guessImg: UIImageView!
    @IBOutlet weak var findTableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let (font, userColor) = getUserSetting()
        
        guessNameLabel.font = font.withSize(80)
        guessNameLabel.textColor = userColor

        findTableButton.titleLabel?.font = font.withSize(50)
        findTableButton.setTitleColor(userColor, for: .normal)
        findTableButton.titleLabel?.textAlignment = .center
        findTableButton.layer.cornerRadius = findTableButton.frame.height / 2
    }
}
