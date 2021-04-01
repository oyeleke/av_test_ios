//
//  WelcomeViewController.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class WelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var welcomeUserLabel: UILabel!
    
    // MARK: - Lifecycle Events
    
    var viewModel: WelcomeViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func bindToViewModel() {
        
    }
    
    // MARK: - Actions
    
    @IBAction func letsDoItTapped(_ sender: UIButton) {
        viewModel.goToProfilePicture()
    }
    
}
