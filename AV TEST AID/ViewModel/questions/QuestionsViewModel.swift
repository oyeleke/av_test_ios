//
//  QuestionsViewModel.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 26/06/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class QuestionsViewModel : BaseViewModel {
    
    let getQuestionsState = BehaviorRelay(value: false)
    
    func getQuestionsFromApi(_ realm: Realm){
        state.accept(.loading("Initializing"))
        AVTestService.sharedInstance.fetchQuestions()
            .subscribe( onNext: { (questions) in
                var questionData : [Question] = []
                print("questions got here")
                for question in questions.questions{
                    questionData.append(Question(questionRest: question))
                }
                Question.insertQuestions(questions: questionData, realm: realm)
                self.getQuestionsState.accept(true)
                self.state.accept(.idle)
            }, onError:  { [weak self] error in
                if let apiError = error as? APIError{
                    print("\(apiError)")
                    self?.state.accept(.error(apiError.errorMessage))
                } else {
                     print("\(error)")
                    self?.state.accept(.error(error.localizedDescription))
                }
            }).disposed(by: disposeBag)
    }
    
}
