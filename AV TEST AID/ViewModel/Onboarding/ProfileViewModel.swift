//
//  ProfileViewModel.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ProfileViewModel: BaseViewModel {

    let professions = BehaviorRelay<[Profession]>(value: [])
    let nations = BehaviorRelay(value: ["Nigeria", "Ghana", "Liberia", "Congo", "Uganda", "South Africa"])

    override init() {
        super.init()
        getProfessions()
    }

    private func getProfessions() {
        state.accept(.loading(""))

        AVTestService.sharedInstance
            .fetchProfessions()
            .subscribe(onNext: { professions in
                self.state.accept(.idle)
                self.professions.accept(professions)
            }, onError: { [weak self] error in
                if let apiError = error as? APIError {
                    self?.state.accept(.error(apiError.errorMessage))
                } else {
                    self?.state.accept(.error(error.localizedDescription))
                }
            }).disposed(by: disposeBag)
    }

    func navigateToHome() {
        AppNavigator.shared.navigate(to: HomeRoutes.home, with: .changeRoot)
    }

    func onboardUser(professionIndex: Int, licenseNumber: String, nationality: String) {
        state.accept(.loading(""))

        AVTestService.sharedInstance
                .onboardUser(onboardRequest: OnboardUserRequest(licenseNumber: licenseNumber, nationality: nationality))
                .subscribe(onNext: { user in
                    self.state.accept(.idle)
                    self.navigateToHome()
                }, onError: { [weak self] error in
                    if let apiError = error as? APIError {
                        self?.state.accept(.error(apiError.errorMessage))
                    } else {
                        self?.state.accept(.error(error.localizedDescription))
                    }
                }).disposed(by: disposeBag)
    }

}
