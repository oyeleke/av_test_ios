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

class WelcomeViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var welcomeUserLabel: UILabel!

    // MARK: - Lifecycle Events

    var viewModel: WelcomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func bindToViewModel() {
        viewModel.firstName.subscribe(onNext: { firstName in
            self.welcomeUserLabel.text = "Welcome, \(firstName)"
        }).disposed(by: disposeBag)
    }

    override func getViewModel() -> BaseViewModel {
        viewModel
    }

    // MARK: - Actions

    @IBAction func letsDoItTapped(_ sender: UIButton) {
        viewModel.navigateToProfilePicture()
    }

}
