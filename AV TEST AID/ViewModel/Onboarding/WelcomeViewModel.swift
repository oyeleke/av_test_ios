//
//  WelcomeViewModel.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class WelcomeViewModel: BaseViewModel {

    let firstName = BehaviorRelay(value: "")

    override init() {
        super.init()
        if let user = UserDataManager.currentUser {
            firstName.accept(user.firstName)
        }
    }

    func navigateToProfilePicture() {
        AppNavigator.shared.navigate(to: OnboardingRoutes.profilePicture, with: .push)
    }

}
