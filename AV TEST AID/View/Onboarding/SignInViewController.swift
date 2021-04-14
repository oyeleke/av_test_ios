//
//  SignInViewController.swift
//  AV TEST AID
//
//  Created by Rootstrap on 5/22/17.
//  Copyright © 2017 Rootstrap. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MaterialComponents

class SignInViewController: BaseViewController {

    // MARK: - Outlets

    @IBOutlet weak var emailField: MDCTextField!
    private var emailController: OutlinedTextInputController!

    @IBOutlet weak var passwordField: MDCTextField!
    private var passwordController: OutlinedTextInputController!

    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var signUpInsteadLabel: UILabel!

    // MARK: - Lifecycle Events

    var viewModel: SignInViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        emailController = OutlinedTextInputController(textInput: emailField)
        passwordController = OutlinedTextInputController(textInput: passwordField)

        forgotPasswordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped(_:))))
        signUpInsteadLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signUpInsteadTapped(_:))))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func getViewModel() -> BaseViewModel {
        viewModel
    }

    // MARK: - Actions

    @objc func forgotPasswordTapped(_ sender: UITapGestureRecognizer) {
        viewModel.forgotPassword()
    }

    @objc func signUpInsteadTapped(_ sender: UITapGestureRecognizer) {
        viewModel.navigateToSignUp()
    }

    @IBAction func onSignInClicked(_ sender: UIButton) {
    }

}
