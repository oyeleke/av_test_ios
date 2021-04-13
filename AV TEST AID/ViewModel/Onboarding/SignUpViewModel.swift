//
//  SignUpViewModel.swift
//  AV TEST AID
//
//  Created by German on 8/21/18.
//  Copyright © 2018 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SignUpViewModel: BaseViewModel {

    func signup(withDetails registerRequest: RegisterUserRequest) {
        state.accept(.loading("Signing up..."))

        AVTestService.sharedInstance
                .registerUser(user: registerRequest)
                .subscribe(onNext: { user in
                    self.state.accept(.idle)
                    AppNavigator.shared.navigate(to: OnboardingRoutes.otp, with: .push)
                }, onError: { [weak self] error in
                    if let apiError = error as? APIError {
                        self?.state.accept(.error(apiError.errorMessage))
                    } else {
                        self?.state.accept(.error(error.localizedDescription))
                    }
                }).disposed(by: disposeBag)
    }

}
