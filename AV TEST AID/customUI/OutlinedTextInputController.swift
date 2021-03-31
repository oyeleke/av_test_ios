//
//  TextInputControllerOutlined.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 31/03/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import MaterialComponents

class OutlinedTextInputController: MDCTextInputControllerOutlined {
    
    override init() {
        super.init()
    }
    
    required init(textInput input: (UIView & MDCTextInput)?) {
        super.init(textInput: input)
        borderFillColor = UIColor.clear
        input?.clearButtonMode = .never
        // TODO Set inoput font
//        textInputFont = R.font.muliMedium(size: 16.0)
    }
    
}