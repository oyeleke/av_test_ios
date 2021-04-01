//
//  OTPViewController.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 31/03/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import OTPFieldView

class OTPViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var otpView: OTPFieldView! {
        didSet { setupOTPView() }
    }
    @IBOutlet weak var codeExpiresLabel: UILabel!
    @IBOutlet weak var resendOtpLabel: UILabel!
    
    // MARK: - Lifecycle Events
    
    var viewModel: OTPViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    private func bindToViewModel() {
        
    }
    
    private func setupOTPView() {
        otpView.fieldsCount = 4
        otpView.fieldBorderWidth = 1
        otpView.defaultBorderColor = UIColor(named: "textFieldHintColor")!
        otpView.filledBorderColor = UIColor(named: "aviBlue")!
        otpView.cursorColor = UIColor(named: "textFieldHintColor")!
        otpView.displayType = .roundedCorner
        otpView.fieldSize = 45
        otpView.separatorSpace = 16
        otpView.shouldAllowIntermediateEditing = false
        otpView.fieldFont = UIFont(name: "Quicksand-Regular", size: CGFloat(17))!
        otpView.secureEntry = false
        otpView.delegate = self
        otpView.initializeUI()
    }
    
    @IBAction func verifyNowTapped(_ sender: Any) {
        viewModel.goToWelcomeScreen()
    }
    
}

extension OTPViewController: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        print(index)
        return true
    }
    
    func enteredOTP(otp: String) {
        print(otp)
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        print(hasEnteredAll)
        return hasEnteredAll
    }
    
    
}
