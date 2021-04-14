//
//  ResetPasswordViewController.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class ResetPasswordViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var newPasswordField: PasswordToggleTextField!
    @IBOutlet weak var confirmPasswordField: PasswordToggleTextField!

    private var newPasswordController: OutlinedTextInputController!
    private var confirmPasswordController: OutlinedTextInputController!

    // MARK: - Lifecycle Events

    var viewModel: ResetPasswordViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindToViewModel()
    }

    private func setupViews() {
        newPasswordController = OutlinedTextInputController(textInput: newPasswordField)
        confirmPasswordController = OutlinedTextInputController(textInput: confirmPasswordField)
    }

    private func bindToViewModel() {
        viewModel.passwordResetState.subscribe(onNext: { state in
            if state {
                let action = UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
                    self?.viewModel.popUpToSignIn()
                }
                self.showDialog(withMessage: "Your password has been reset successfully. Continue to sign in", action: action)
            }
        }).disposed(by: disposeBag)
    }

    override func getViewModel() -> BaseViewModel {
        viewModel
    }

    // MARK: - Actions

    @IBAction func doneTapped(_ sender: UIButton) {
        Validator.clearErrors(textControllers: newPasswordController, confirmPasswordController)

        if !Validator.validate(textControllers: newPasswordController) {
            return
        }

        if newPasswordField.text != confirmPasswordField.text {
            let errorMessage = "Passwords dont match"
            confirmPasswordController.setErrorText(errorMessage, errorAccessibilityValue: errorMessage)
            return
        }

        viewModel.resetPassword(newPassword: newPasswordField.text!)
    }

}
