//
//  ResetPasswordViewModel.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ResetPasswordViewModel: BaseViewModel {

    let passwordResetState = BehaviorRelay(value: false)

    func resetPassword(newPassword password: String) {
        guard let user = UserDataManager.currentUser else { return }
        state.accept(.loading(""))

        AVTestService.sharedInstance
                .resetPassword(resetRequest: ResetPasswordRequest(id: user.id, newPassword: password))
                .subscribe(onNext: { user in
                    self.state.accept(.idle)
                    self.passwordResetState.accept(true)
                }, onError: { [weak self] error in
                    if let apiError = error as? APIError {
                        self?.state.accept(.error(apiError.errorMessage))
                    } else {
                        self?.state.accept(.error(error.localizedDescription))
                    }
                }).disposed(by: disposeBag)
    }

    func popUpToSignIn() {
        AppNavigator.shared.popTo(route: OnboardingRoutes.signIn)
    }

}
