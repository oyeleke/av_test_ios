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

class ResetPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var newPasswordField: PasswordToggleTextField!
    @IBOutlet weak var confirmPasswordField: PasswordToggleTextField!
    
    private var newPasswordController: OutlinedTextInputController!
    private var confirmPasswordController: OutlinedTextInputController!
    
    // MARK: - Lifecycle Events
    
    var viewModel: ResetPasswordViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        setupViews()
    }
    
    private func bindToViewModel() {
        
    }
    
    private func setupViews() {
        newPasswordController = OutlinedTextInputController(textInput: newPasswordField)
        confirmPasswordController = OutlinedTextInputController(textInput: confirmPasswordField)
    }
    
    // MARK: - Actions
    
    @IBAction func doneTapped(_ sender: UIButton) {
    }
    
}
