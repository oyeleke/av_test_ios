//
//  CustomDesignableView.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 22/03/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import UIKit

class CustomDesignableView: UIView {

   @IBInspectable var cornerRadius : CGFloat = 0{
       didSet{
           layer.cornerRadius = cornerRadius
       }
   }
    
    @IBInspectable var shadowRadius : CGFloat = 0{
        didSet{
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 1
            layer.shadowOffset = .zero
            layer.shadowRadius = shadowRadius
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }

}
