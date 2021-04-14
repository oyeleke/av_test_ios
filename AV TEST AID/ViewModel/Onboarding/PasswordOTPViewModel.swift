//
//  PasswordOTPViewModel.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class PasswordOTPViewModel: BaseViewModel {

    func verifyPasswordCode(withOtp otp: String) {
        state.accept(.loading("Verifying..."))
        guard let user = UserDataManager.currentUser else { return }

        AVTestService.sharedInstance
                .verifyPasswordCode(verifyRequest: VerifyPasswordCodeRequest(email: user.email, verificationCode: otp))
                .subscribe(onNext: { user in
                    self.state.accept(.idle)
                    AppNavigator.shared.navigate(to: OnboardingRoutes.resetPassword, with: .push)
                }, onError: { [weak self] error in
                    if let apiError = error as? APIError {
                        self?.state.accept(.error(apiError.errorMessage))
                    } else {
                        self?.state.accept(.error(error.localizedDescription))
                    }
                }).disposed(by: disposeBag)
    }

    func resendPasswordCode() {
        state.accept(.loading(""))
        guard let user = UserDataManager.currentUser else { return }

        AVTestService.sharedInstance
                .resendPasswordCode(initiateRequest: InitiateResetPasswordRequest(email: user.email))
                .subscribe(onNext: { user in
                    self.state.accept(.idle)
                }, onError: { [weak self] error in
                    if let apiError = error as? APIError {
                        self?.state.accept(.error(apiError.errorMessage))
                    } else {
                        self?.state.accept(.error(error.localizedDescription))
                    }
                }).disposed(by: disposeBag)
    }

}
