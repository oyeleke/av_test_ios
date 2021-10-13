//
//  CustomOptionView.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 30/09/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import UIKit

class CustomOptionView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    
    var optionStateColor: OptionStates = OptionStates.OptionNotSelected {
        didSet {
            switch optionStateColor {
            case .OptionNotSelected:
                layer.backgroundColor = UIColor(named: "OptionNotSelectedState")?.cgColor
                break
            case .OptionIsCorrect:
                layer.backgroundColor = UIColor(named: "OptionCorrectScore")?.cgColor
                break
            case .OptionIsWrong:
                layer.backgroundColor = UIColor(named: "OptionNotCorrectColor")?.cgColor
                break
            case .OptionSelected:
                layer.backgroundColor = UIColor(named: "OptionSelectedBlue")?.cgColor
                break
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
