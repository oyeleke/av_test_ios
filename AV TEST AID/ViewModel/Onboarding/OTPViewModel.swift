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

class OTPViewModel {

    let disposeBag = DisposeBag()

    let state = BehaviorRelay(value: ViewModelState.idle)

    func goToWelcomeScreen() {
        AppNavigator.shared.navigate(to: OnboardingRoutes.welcome, with: .push)
    }

}
