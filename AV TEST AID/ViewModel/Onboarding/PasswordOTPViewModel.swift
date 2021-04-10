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

class PasswordOTPViewModel {

    let disposeBag = DisposeBag()

    let state = BehaviorRelay(value: ViewModelState.idle)

    func goToResetPassword() {
        AppNavigator.shared.navigate(to: OnboardingRoutes.resetPassword, with: .push)
    }

}
