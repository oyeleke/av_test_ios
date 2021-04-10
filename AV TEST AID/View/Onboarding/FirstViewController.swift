//
//  ViewController.swift
//  AV TEST AID
//
//  Created by Rootstrap on 15/2/16.
//  Copyright © 2016 Rootstrap. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FirstViewController: UIViewController {

    // MARK: - Outlets

    // MARK: - Lifecycle

    var viewModel: FirstViewModel!
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
        viewModel.state.asObservable()
                .subscribe(onNext: { state in
                    if state == .loading {
                        UIApplication.showNetworkActivity()
                    } else {
                        UIApplication.hideNetworkActivity()
                    }
                }).disposed(by: disposeBag)
    }

    // MARK: - Actions

    @IBAction func createAccountTapped(_ sender: Any) {
        viewModel.signUp()
    }

    @IBAction func signInTapped(_ sender: Any) {
        viewModel.signIn()
    }

}
