//
//  PasswordOTPViewController.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import OTPFieldView

class PasswordOTPViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var otpFieldView: OTPFieldView! {
        didSet {
            setupOTPView()
        }
    }
    @IBOutlet weak var tryAgainlabel: UILabel!


    // MARK: - Lifecycle Events

    var viewModel: PasswordOTPViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }

    private func setupOTPView() {
        otpFieldView.fieldsCount = 4
        otpFieldView.fieldBorderWidth = 1
        otpFieldView.defaultBorderColor = UIColor(named: "textFieldHintColor")!
        otpFieldView.filledBorderColor = UIColor(named: "aviBlue")!
        otpFieldView.cursorColor = UIColor(named: "textFieldHintColor")!
        otpFieldView.displayType = .roundedCorner
        otpFieldView.fieldSize = 45
        otpFieldView.separatorSpace = 16
        otpFieldView.shouldAllowIntermediateEditing = false
        otpFieldView.fieldFont = UIFont(name: "Quicksand-Regular", size: CGFloat(17))!
        otpFieldView.secureEntry = false
        otpFieldView.delegate = self
        otpFieldView.initializeUI()
    }

    private func bindToViewModel() {

    }

    // MARK: - Actions

    @IBAction func verifyNowTapped(_ sender: Any) {
        viewModel.goToResetPassword()
    }

}

extension PasswordOTPViewController: OTPFieldViewDelegate {
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
