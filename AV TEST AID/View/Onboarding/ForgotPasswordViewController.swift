//
//  ForgotPasswordViewController.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import MaterialComponents

class ForgotPasswordViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailAddressField: MDCTextField!
    private var emailController: OutlinedTextInputController!

    @IBOutlet weak var signUpNowLabel: UILabel!

    // MARK: - Lifecycle Events

    var viewModel: ForgotPasswordViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func getViewModel() -> BaseViewModel {
        viewModel
    }

    private func setupViews() {
        emailController = OutlinedTextInputController(textInput: emailAddressField)
        
        signUpNowLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signUpNowTapped(_:))))
        signUpNowLabel.isUserInteractionEnabled = true
    }

    @IBAction func resetPasswordTapped(_ sender: Any) {
        if Validator.validate(minLength: 5, errorMessage: "Enter your email address", textControllers: emailController) {
            viewModel.initiatePasswordReset(emailAddress: emailAddressField.text!)
        }
    }
    
    @objc func signUpNowTapped(_ sender: UITapGestureRecognizer) {
        viewModel.navigateToSignUp()
    }

}
