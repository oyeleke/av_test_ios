//
//  ReviewQuestionsViewModel.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 06/10/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class ReviewQuestionViewModel : BaseViewModel {
    
    let getQuestionsState = BehaviorRelay(value: false)
    let currentQuestion = BehaviorRelay<QuestionSessionItem?>(value: nil)
    var currentQuestionNumber = -1
    var currentSessionQuestionList: [QuestionSessionItem] = []
    var currentSessionOptionList: [String: OptionsSelected] = [:]
    var currentQuestionSessionOptional : QuestionSession? = nil
    var totalQuestions = 0;
    var markedQuestionSet : Set<String> = []
    
    
    func setupQuestionsForReview(realm: Realm){
        currentQuestionSessionOptional = QuestionSession.getQuestionSession(realm)
        guard let currentQuestionSession = currentQuestionSessionOptional else {
            return
        }
        
        for questionSessionItems in currentQuestionSession.questionSessions {
            currentSessionQuestionList.append(questionSessionItems)
        }
        
        for optionSelected in currentQuestionSession.optionSelectedList {
            currentSessionOptionList[optionSelected.id] = optionSelected
        }
        
        markedQuestionSet = MarkedQuestions.getAllMarkedQuestionsAsSet(realm)
        
        totalQuestions = currentQuestionSession.totalQuestions
        onNextPressed()
    }
    
    
    func onNextPressed(){
        if currentQuestionNumber+1 < totalQuestions {
            currentQuestionNumber = currentQuestionNumber + 1
            currentQuestion.accept(currentSessionQuestionList[currentQuestionNumber])
        }
    }
    
    func onOnPrevPressed(){
        if currentQuestionNumber >= 0 {
            currentQuestionNumber = currentQuestionNumber - 1
            currentQuestion.accept(currentSessionQuestionList[currentQuestionNumber])
        }
    }
}
