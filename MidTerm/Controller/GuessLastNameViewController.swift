//
//  GuessLastNameViewController.swift
//  MidTerm
//
//  Created by Minh Tri on 11/20/20.
//

import UIKit

class GuessLastNameViewController: UIViewController {
    
    @IBOutlet weak var containerAlphabet: UIStackView!
    var listButtons: [UIButton?] = []
    @IBOutlet weak var selectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (font, _) = getUserSetting()
        selectLabel.font = font.withSize(font.pointSize + 20)
        
        // In viewDidLoad, subview not add to window
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
                button?.layer.cornerRadius = 20
                button?.layer.masksToBounds = true
                button?.titleLabel?.font = font.withSize(font.pointSize + 40)
            }
        }
        
        selectLabel.outline(strokeWidth: -1, strokeColor: .white)
    }
    
    
    @IBAction func alphabetButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SearchNameToSearchResult", sender: self)
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
