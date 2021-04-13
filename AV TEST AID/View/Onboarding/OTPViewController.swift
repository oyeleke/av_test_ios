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

class OTPViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var otpView: OTPFieldView! {
        didSet {
            setupOTPView()
        }
    }
    @IBOutlet weak var codeExpiresLabel: UILabel!
    @IBOutlet weak var resendOtpLabel: UILabel!

    // MARK: - Lifecycle Events

    var viewModel: OTPViewModel!
    var enteredOtp: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func getViewModel() -> BaseViewModel {
        viewModel
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
        if enteredOtp.count == 4 {
            viewModel.verifyUser(withOtp: enteredOtp)
        }
    }

}

extension OTPViewController: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        true
    }

    func enteredOTP(otp: String) {
        print(otp)
        enteredOtp = otp
    }

    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        if hasEnteredAll {
            viewModel.verifyUser(withOtp: enteredOtp)
        }
        return hasEnteredAll
    }


}
