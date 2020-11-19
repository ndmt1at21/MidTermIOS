//
//  AlertCustom.swift
//  MidTerm
//
//  Created by Minh Tri on 11/18/20.
//

import UIKit

class AlertCustom: UIView {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertSymbol: UILabel!
    @IBOutlet weak var alerMessage: UILabel!
    @IBOutlet weak var buttonOK: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        alertSymbol.layer.cornerRadius = 100
        alertSymbol.layer.borderWidth = 2
        alertSymbol.layer.borderColor = UIColor("#fff", 1).cgColor
        
        buttonOK.layer.cornerRadius = 2
        buttonCancel.layer.cornerRadius = 2
    }
    
    func viewFromAlerCustom() -> UIView {
        let nib = UINib(nibName: "AlertCustom", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    @IBAction func buttonOKPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func buttonCancelPressed(_ sender: UIButton) {
    }
}
