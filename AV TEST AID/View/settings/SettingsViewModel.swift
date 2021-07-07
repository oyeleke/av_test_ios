//
//  SettingsViewModel.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 05/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SettingsViewModel: BaseViewModel  {
    
    //let changePasswordState = BehaviorRelay(value: false)
    
    let fetchUserState = BehaviorRelay<User?>(value: nil)
    func fetchUser(){
        //guard let user = UserDataManager.currentUser else { return }
        state.accept(.loading("fetching user's details"))
        AVTestService.sharedInstance.fetchUser()
            .subscribe(onNext: { user in
                self.state.accept(.idle)
                self.fetchUserState.accept(user)
            }, onError: {[weak self] error in
                if let apiError = error as? APIError {
                    self?.state.accept(.idle)
                    self?.state.accept(.error(apiError.errorMessage))
                } else {
                    self?.state.accept(.idle)
                    self?.state.accept(.error(error.localizedDescription))
                }
                
            }).disposed(by: disposeBag)
    }
}
