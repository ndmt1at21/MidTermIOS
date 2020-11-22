//
//  GuessWelcomeViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/17/20.
//

import UIKit

class GuessWelcomeViewController: UIViewController {
    
    @IBOutlet weak var guessNameLabel: UILabel!
    @IBOutlet weak var guessImg: UIImageView!
    @IBOutlet weak var findTableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let (font, userColor) = getUserSetting()
        UILabel.appearance().font = font
        UILabel.appearance().textColor = userColor
        UIButton.appearance().titleLabel?.font = font
        UIButton.appearance().tintColor = userColor
        UIButton.appearance().setTitleColor(userColor, for: .normal)
        
        guessNameLabel.font = font.withSize(font.pointSize + 70)
        findTableButton.titleLabel?.font = font.withSize(font.pointSize + 30)
        findTableButton.titleLabel?.textAlignment = .center
        findTableButton.layer.cornerRadius = findTableButton.frame.height / 2
    }
}
