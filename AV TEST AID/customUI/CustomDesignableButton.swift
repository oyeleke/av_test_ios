//
//  CustomDesignableButton.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 21/03/2021.
//  
//

import UIKit

@IBDesignable class CustomDesignableButton: UIButton {

    @IBInspectable var borderColor: UIColor = UIColor.clear {

        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }


    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    func setState(_ state: Bool) {
        alpha = state ? 1 : 0.5
        isEnabled = state
    }

}
