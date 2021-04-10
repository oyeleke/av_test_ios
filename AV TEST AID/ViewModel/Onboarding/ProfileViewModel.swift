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

class ProfileViewModel {

    let disposeBag = DisposeBag()

    let state = BehaviorRelay(value: ViewModelState.idle)

}
