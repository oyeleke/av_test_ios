//
//  KnowldgeScoreViewModel.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 19/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class KnowledgeScoreViewModel: BaseViewModel {
    
    let fetchScoreState = BehaviorRelay(value: 0.0)
    
    
    func fetchScore(){
        state.accept(.loading("Fetching user's score"))
        AVTestService.sharedInstance.fetchScores()
            .subscribe(onNext: {state in
                self.state.accept(.idle)
                self.fetchScoreState.accept(state)
                
            },
                       onError: {[weak self] error in
                        if let apiError = error as? APIError{
                            self?.state.accept(.error(apiError.errorMessage))
                        } else {
                            self?.state.accept(.error(error.localizedDescription))
                        }
                        
            }).disposed(by: disposeBag)
    }
    
    func popToDashboard() {
       
    }
}
