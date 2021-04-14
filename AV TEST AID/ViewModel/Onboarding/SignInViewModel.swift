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

    func forgotPassword() {
        AppNavigator.shared.navigate(to: OnboardingRoutes.forgotPassword, with: .push)
    }

}
