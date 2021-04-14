//
//  SignInViewModel.swift
//  AV TEST AID
//
//  Created by German on 8/3/18.
//  Copyright © 2018 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SignInViewModel: BaseViewModel {

    func navigateToSignUp() {
        AppNavigator.shared.popToRoot( )
        AppNavigator.shared.navigate(to: OnboardingRoutes.signUp, with: .push)
    }

    func navigateToForgotPassword() {
        AppNavigator.shared.navigate(to: OnboardingRoutes.forgotPassword, with: .push)
    }

    func signIn(withEmail email: String, andPassword password: String) {
        state.accept(.loading("Authenticating..."))

        AVTestService.sharedInstance
                .signIn(signInRequest: SignInUserRequest(email: email, password: password))
                .subscribe(onNext: { user in
                    self.state.accept(.idle)
                    AppNavigator.shared.navigate(to: HomeRoutes.home, with: .changeRoot)
                }, onError: { [weak self] error in
                    if let apiError = error as? APIError {
                        self?.state.accept(.error(apiError.errorMessage))
                    } else {
                        self?.state.accept(.error(error.localizedDescription))
                    }
                }).disposed(by: disposeBag)
    }

}
