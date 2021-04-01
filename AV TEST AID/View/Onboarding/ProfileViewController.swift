//
//  ProfileViewController.swift
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

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var licenseNumberField: MDCTextField!
    private var licenseNumberController: OutlinedTextInputController!
    
    
    // MARK: - LifeCycle Events
    
    var viewModel: ProfileViewModel!
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        setupViews()
    }
    
    private func bindToViewModel() {
        
    }
    
    private func setupViews() {
        licenseNumberController = OutlinedTextInputController(textInput: licenseNumberField)
    }
    
    // MARK: - Actions
    
    @objc func skipTapped() {
        
    }
    
}
