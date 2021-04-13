//
//  OTPViewModel.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 31/03/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class OTPViewModel: BaseViewModel {

    func verifyUser(withOtp otp: String) {
        state.accept(.loading("Verifying..."))

        AVTestService.sharedInstance
                .verifyOtp(verifyRequest: VerifyUserRequest(verificationCode: otp))
                .subscribe(onNext: { user in
                    self.state.accept(.idle)
                    AppNavigator.shared.navigate(to: OnboardingRoutes.welcome, with: .push)
                }, onError: { [weak self] error in
                    if let apiError = error as? APIError {
                        self?.state.accept(.error(apiError.errorMessage))
                    } else {
                        self?.state.accept(.error(error.localizedDescription))
                    }
                }).disposed(by: disposeBag)
    }

}
