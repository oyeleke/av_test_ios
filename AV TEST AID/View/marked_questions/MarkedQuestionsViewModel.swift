//
//  MarkedQuestionsViewModel.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 07/10/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class MarkedQuestionsViewModel : BaseViewModel {
    
    let currentQuestion = BehaviorRelay<Question?>(value: nil)
    var currentQuestionNumber = -1
    var currentMarkedQuestionList: [Question] = []
    var totalQuestions = 0;
    var markedQuestionSet : Set<String> = []
    
    func setupMarkedQuestion(_ realm : Realm){
        currentMarkedQuestionList = Question.getAllBookMarkedQuestion(realm)
        markedQuestionSet = MarkedQuestions.getAllMarkedQuestionsAsSet(realm)
        totalQuestions = currentMarkedQuestionList.count
        onNextPressed()
    }
    
    func onNextPressed(){
        if currentQuestionNumber+1 < totalQuestions {
              currentQuestionNumber = currentQuestionNumber + 1
              currentQuestion.accept(currentMarkedQuestionList[currentQuestionNumber])
          }
    }
    
    func onPrevPressed(){
        if currentQuestionNumber >= 0 {
                  currentQuestionNumber = currentQuestionNumber - 1
                  currentQuestion.accept(currentMarkedQuestionList[currentQuestionNumber])
              }
    }
    
    func removeQuestionFromList(forQuestionId questionId: String){
        do {
             currentMarkedQuestionList.removeAll(where: {$0.id == questionId})
        } catch {
            self.state.accept(.error("An Error Occurred"))
        }
       
    }
}
