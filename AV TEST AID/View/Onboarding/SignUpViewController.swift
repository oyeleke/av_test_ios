//
//  SignUpViewController.swift
//  AV TEST AID
//
//  Created by Rootstrap on 5/22/17.
//  Copyright © 2017 Rootstrap. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MaterialComponents

class SignUpViewController: BaseViewController {

    // MARK: - Outlets

    @IBOutlet weak var firstNameField: MDCTextField!
    @IBOutlet weak var lastNameField: MDCTextField!
    @IBOutlet weak var emailAddressField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!

    private var firstNameController: OutlinedTextInputController!
    private var lastNameController: OutlinedTextInputController!
    private var emailAddressController: OutlinedTextInputController!
    private var passwordController: OutlinedTextInputController!

    // MARK: - Lifecycle Events

    var viewModel: SignUpViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupViews() {
        firstNameController = OutlinedTextInputController(textInput: firstNameField)
        lastNameController = OutlinedTextInputController(textInput: lastNameField)
        emailAddressController = OutlinedTextInputController(textInput: emailAddressField)
        passwordController = OutlinedTextInputController(textInput: passwordField)
    }

    private func bindToViewModel() {

    }

    override func getViewModel() -> BaseViewModel {
        viewModel
    }

    // MARK: - Actions

    @IBAction func signUpTapped(_ sender: UIButton) {
        Validator.clearErrors(textControllers: firstNameController, lastNameController, emailAddressController,
                passwordController)

        if !Validator.validate(textControllers: firstNameController, lastNameController, emailAddressController,
                passwordController) {
            return
        }

        viewModel.signup(withDetails: RegisterUserRequest(email: emailAddressField.text!,
                firstName: firstNameField.text!, lastName: lastNameField.text!, password: passwordField.text!))
    }


}
