//
//  ForgotPasswordViewModel.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ForgotPasswordViewModel: BaseViewModel {

    func initiatePasswordReset(emailAddress: String) {
        state.accept(.loading(""))

        AVTestService.sharedInstance
                .initiatePasswordReset(initiateRequest: InitiateResetPasswordRequest(email: emailAddress))
                .subscribe(onNext: { user in
                    self.state.accept(.idle)
                    AppNavigator.shared.navigate(to: OnboardingRoutes.passwordOtp, with: .push)
                }, onError: { [weak self] error in
                    if let apiError = error as? APIError {
                        self?.state.accept(.error(apiError.errorMessage))
                    } else {
                        self?.state.accept(.error(error.localizedDescription))
                    }
                }).disposed(by: disposeBag)
    }

}
