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
        bindViewModel()
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
    
    private func bindViewModel(){
        viewModel.signInState.subscribe(onNext: {state in
            if state {
                self.onUserSignedIn()
            }
        }).disposed(by: disposeBag)
    }

    // MARK: - Actions

    @objc func forgotPasswordTapped(_ sender: UITapGestureRecognizer) {
        viewModel.navigateToForgotPassword()
    }

    @objc func signUpInsteadTapped(_ sender: UITapGestureRecognizer) {
        viewModel.navigateToSignUp()
    }

    @IBAction func onSignInClicked(_ sender: UIButton) {
        Validator.clearErrors(textControllers: emailController, passwordController)

        if !Validator.validate(textControllers: emailController, passwordController) {
            return
        }

        viewModel.signIn(withEmail: emailField.text!, andPassword: passwordField.text!)
    }
    
        func onUserSignedIn() {
            let dashboard = (UIStoryboard.instantiateViewController(DashboardTabViewController.self, storyboardIdentifier: "DashBoardStorryBoard") ?? UITabBarController()) as UITabBarController
            view.window?.rootViewController = dashboard
            view.window?.makeKeyAndVisible()
        }
        
    }


    protocol SignInContract {
        func onUserSignedIn()
    }

