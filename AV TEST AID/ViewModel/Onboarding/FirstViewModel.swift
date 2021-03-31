//
//  FirstViewModel.swift
//  AV TEST AID
//
//  Created by German Stabile on 11/2/18.
//  Copyright © 2018 TopTier labs. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import RxCocoa
import RxSwift

class FirstViewModel {
  let disposeBag = DisposeBag()

  var state = BehaviorRelay(value: ViewModelState.idle)
  
  func signIn() {
    AppNavigator.shared.navigate(to: OnboardingRoutes.signIn, with: .push)
  }

  func signUp() {
    AppNavigator.shared.navigate(to: OnboardingRoutes.signUp, with: .push)
  }
  
}
