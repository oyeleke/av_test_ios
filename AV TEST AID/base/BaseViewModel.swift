//
// Created by Efe Ejemudaro on 12/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BaseViewModel {

    var state = BehaviorRelay(value: ViewModelState.idle)
    let disposeBag = DisposeBag()

}
