//
//  GuessLastNameViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/20/20.
//

import UIKit

class GuestLastNameViewController: UIViewController {
    
    @IBOutlet weak var containerAlphaHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerAlphabet: UIStackView!
    @IBOutlet weak var selectLabel: UILabel!
    
    var listButtons: [UIButton?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (font, userColor) = getUserSetting()
        
        selectLabel.font = font.withSize(font.pointSize + 20)
        selectLabel.textColor = userColor
        selectLabel.outline(strokeWidth: -1, strokeColor: .white)
        containerAlphaHeightConstraint.constant = containerAlphabet.bounds.width - 50
    }
    
    override func viewWillLayoutSubviews() {
        for container in containerAlphabet.subviews {
            for button in container.subviews {
                listButtons.append(button as? UIButton)
            }
        }

        for button in listButtons {
            if button?.alpha != 0 {
                button?.addGradientLayer(
                    colors: [
                        UIColor("#89f7fe", 1).cgColor,
                        UIColor("#66a6ff", 1).cgColor
                    ],
                    startPoint: CGPoint(x: 0, y: 0),
                    endPoint: CGPoint(x: 1, y: 0.5)
                )
                button?.layer.cornerRadius = 30
                button?.layer.masksToBounds = true
                button?.setTitleColor(selectLabel.textColor, for: .normal)
                button?.titleLabel?.font = selectLabel.font.withSize(selectLabel.font.pointSize + 30)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let des = segue.destination as? GuestSearchResultViewController {
            if let char = (sender as? UIButton)?.titleLabel?.text {
                des.lastNameCharSelected = char
            }
        }
    }
    
    @IBAction func alphabetButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.segue.searchNameToSearchResult, sender: sender)
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
