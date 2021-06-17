//
//  ChangePasswordViewModel.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 12/05/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ChangePasswordViewModel : BaseViewModel {
    
    let changePasswordState = BehaviorRelay(value: false)
    
    func changePassword(oldPassword: String, newPassword: String){
        let changePasswordRequest = ChangePasswordRequest(old: oldPassword, new: newPassword)
        state.accept(.loading("changing user's password"))
        AVTestService.sharedInstance.changePassword(changeRequest: changePasswordRequest)
            .subscribe(onNext: {state in
                if state {
                    self.state.accept(.idle)
                    self.changePasswordState.accept(true)
                }
            },
                       onError: {[weak self] error in
                        if let apiError = error as? APIError{
                            self?.state.accept(.error(apiError.errorMessage))
                        } else {
                            self?.state.accept(.error(error.localizedDescription))
                        }
                        
            }).disposed(by: disposeBag)
    }
    
    func popToSettings() {
        AppNavigator.shared.dismiss()
    }
}
