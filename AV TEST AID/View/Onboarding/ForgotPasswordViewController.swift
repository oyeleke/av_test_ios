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

class ForgotPasswordViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailAddressField: MDCTextField!
    private var emailController: OutlinedTextInputController!

    @IBOutlet weak var signUpNowLabel: UILabel!

    // MARK: - Lifecycle Events

    var viewModel: ForgotPasswordViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        setupViews()
    }

    private func setupViews() {
        emailController = OutlinedTextInputController(textInput: emailAddressField)
    }

    private func bindToViewModel() {

    }

    @IBAction func resetPasswordTapped(_ sender: Any) {
        viewModel.goToPasswordOtp()
    }

}
