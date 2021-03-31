//
//  PasswordToggleTextField.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 31/03/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import MaterialComponents

class PasswordToggleTextField: MDCTextField {
    
    private let toggleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        toggleButton.setImage(UIImage(named: "ic_password_toggle"), for: .normal)
        toggleButton.addTarget(self, action: #selector(self.toggle), for: .touchUpInside)
        trailingView = toggleButton
        trailingViewMode = .always
        isSecureTextEntry = true
    }
    
    @objc func toggle(_ sender: Any) {
        isSecureTextEntry.toggle()
        let icon = isSecureTextEntry ? UIImage(named: "ic_password_toggle") : UIImage(named: "ic_password_toggle")
        toggleButton.setImage(icon, for: .normal)
    }
    
}
