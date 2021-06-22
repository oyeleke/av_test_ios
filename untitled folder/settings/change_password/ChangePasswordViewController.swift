//
//  ChangePasswordViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 12/05/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//
import Foundation
import UIKit
import RxCocoa
import RxSwift


class ChangePasswordViewController: BaseViewController {
    
    @IBOutlet weak var currentPasswordEditText: PasswordToggleTextField!
    @IBOutlet weak var newPasswordEditText: PasswordToggleTextField!
    @IBOutlet weak var confirmPasswordEditText: PasswordToggleTextField!
    
    private var currentpasswordController: OutlinedTextInputController!
    private var newpasswordController: OutlinedTextInputController!
    private var confirmpasswordController: OutlinedTextInputController!
    
    var viewModel : ChangePasswordViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    func setupView() {
        currentpasswordController = OutlinedTextInputController(textInput: currentPasswordEditText)
        newpasswordController = OutlinedTextInputController(textInput: newPasswordEditText)
        confirmpasswordController = OutlinedTextInputController(textInput: confirmPasswordEditText)
    
    }
    
    override func getViewModel() -> BaseViewModel {
        viewModel
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Navigation
    
    private func bindViewModel(){
        viewModel.changePasswordState.subscribe(onNext: {state in
            if state {
                let action = UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }
                self.showDialog(withMessage: "Your password has been changed successfully", action: action)
            }
            
        }).disposed(by: disposeBag)
    }
    
    @IBAction func saveNewPassword(_ sender: Any) {
        Validator.clearErrors(textControllers: currentpasswordController, newpasswordController, confirmpasswordController)
        
        if !Validator.validate(textControllers: currentpasswordController, newpasswordController) {
            return
        }
        
        if newPasswordEditText.text != confirmPasswordEditText.text {
            let errorMessage = "Passwords dont match"
            confirmpasswordController.setErrorText(errorMessage, errorAccessibilityValue: errorMessage)
            return
        }
        viewModel.changePassword(oldPassword: currentPasswordEditText.text!, newPassword: newPasswordEditText.text!)
    }
}
