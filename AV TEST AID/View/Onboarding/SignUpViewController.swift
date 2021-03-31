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

class SignUpViewController: UIViewController {
    
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
    
    var viewModel: SignUpViewModelWithEmail!
    let disposeBag = DisposeBag()
    
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
//        viewModel.hasValidData.asObservable()
//            .subscribe(onNext: { [weak self] isValid in
//                self?.setSignUpButton(enabled: isValid)
//            }).disposed(by: disposeBag)
//
//        viewModel.state.asObservable()
//            .subscribe(onNext: { [weak self] state in
//                self?.handleStateChange(state: state)
//            }).disposed(by: disposeBag)
//
//        emailField.rx.text.bind(to: viewModel.email).disposed(by: disposeBag)
//        passwordField.rx.text.bind(to: viewModel.password).disposed(by: disposeBag)
//        passwordConfirmationField.rx.text.bind(to: viewModel.passwordConfirmation).disposed(by: disposeBag)
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
