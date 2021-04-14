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

class PasswordOTPViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var otpFieldView: OTPFieldView!
    @IBOutlet weak var tryAgainlabel: UILabel!

    // MARK: - Lifecycle Events

    var viewModel: PasswordOTPViewModel!
    var enteredOtp: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        setupOTPView()

        tryAgainlabel.isUserInteractionEnabled = true
        tryAgainlabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tryAgainTapped(_:))))
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
        otpFieldView.shouldAllowIntermediateEditing = true
        otpFieldView.fieldFont = UIFont(name: "Quicksand-Regular", size: CGFloat(17))!
        otpFieldView.secureEntry = false
        otpFieldView.delegate = self
        otpFieldView.initializeUI()
    }

    override func handleErrorState(with errorMessage: String) {
        super.handleErrorState(with: errorMessage)
        otpFieldView.initializeUI()
        enteredOtp = ""
    }

    override func getViewModel() -> BaseViewModel {
        viewModel
    }

    // MARK: - Actions

    @objc func tryAgainTapped(_ sender: UITapGestureRecognizer) {
        viewModel.resendPasswordCode()
    }

    @IBAction func verifyNowTapped(_ sender: Any) {
        if enteredOtp.count == 4 {
            viewModel.verifyPasswordCode(withOtp: enteredOtp)
        }
    }

}

extension PasswordOTPViewController: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        true
    }

    func enteredOTP(otp: String) {
        print(otp)
        enteredOtp = otp
    }

    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        if hasEnteredAll {
            viewModel.verifyPasswordCode(withOtp: enteredOtp)
        }
        return hasEnteredAll
    }


}
