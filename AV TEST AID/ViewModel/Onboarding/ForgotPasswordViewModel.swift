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

class ForgotPasswordViewModel {

    let disposeBag = DisposeBag()

    let state = BehaviorRelay(value: ViewModelState.idle)

    func goToPasswordOtp() {
        AppNavigator.shared.navigate(to: OnboardingRoutes.passwordOtp, with: .push)
    }

}
