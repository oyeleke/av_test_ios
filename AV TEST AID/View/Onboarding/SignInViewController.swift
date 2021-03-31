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

class SignInViewController: UIViewController {
  
    // MARK: - Outlets
    
    @IBOutlet weak var emailField: MDCTextField!
    private var emailController: OutlinedTextInputController!
    
    @IBOutlet weak var passwordField: MDCTextField!
    private var passwordController: OutlinedTextInputController!
    
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var signUpInsteadLabel: UILabel!
    
    // MARK: - Lifecycle Events
    
    var viewModel: SignInViewModel!
    let disposeBag = DisposeBag()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        emailController = OutlinedTextInputController(textInput: emailField)
        passwordController = OutlinedTextInputController(textInput: passwordField)
        bindToViewModel()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

  private func bindToViewModel() {
//    viewModel.hasValidCredentials.asObservable()
//      .subscribe(onNext: { [weak self] isValid in
//        self?.setLoginButton(enabled: isValid)
//      }).disposed(by: disposeBag)
//
//    viewModel.state.asObservable()
//      .subscribe(onNext: { [weak self] state in
//        self?.handleStateChange(state: state)
//      }).disposed(by: disposeBag)
//
//    emailField.rx.text.bind(to: viewModel.email)
//      .disposed(by: disposeBag)
//    passwordField.rx.text.bind(to: viewModel.password)
//      .disposed(by: disposeBag)
  }
  
  // MARK: - Actions
  
    @IBAction func onSignInClicked(_ sender: UIButton) {
    }
    
    private func handleStateChange(state: ViewModelState) {
        switch state {
        case .loading:
            UIApplication.showNetworkActivity()
        case .error(let errorDescription):
            UIApplication.hideNetworkActivity()
            showMessage(title: "Error", message: errorDescription)
        case .idle:
            UIApplication.hideNetworkActivity()
        }
    }
}
