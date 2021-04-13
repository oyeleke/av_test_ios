//
// Created by Efe Ejemudaro on 12/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import MBProgressHUD

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        getViewModel().state.asObservable()
                .subscribe(onNext: { [weak self] state in
                    self?.handleStateChange(state: state)
                }).disposed(by: disposeBag)
    }

    private func handleStateChange(state: ViewModelState) {
        switch state {
        case .loading(let message):
            showProgressIndicator(withMessage: message)
        case .error(let errorDescription):
            dismissProgressIndicator()
            showMessage(title: "Error", message: errorDescription)
        case .idle:
            dismissProgressIndicator()
        }
    }

    func getViewModel() -> BaseViewModel {
        preconditionFailure("This method must be overridden")
    }

}

extension BaseViewController {

    @objc func showProgressIndicator(withMessage message: String) {
        view.endEditing(true)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.numberOfLines = 0
        hud.label.text = message
        hud.mode = MBProgressHUDMode.indeterminate
        hud.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = false
        UIApplication.showNetworkActivity()
    }

    @objc func dismissProgressIndicator() {
        MBProgressHUD.hide(for: view, animated: true)
        UIApplication.hideNetworkActivity()
        view.isUserInteractionEnabled = true
    }

}