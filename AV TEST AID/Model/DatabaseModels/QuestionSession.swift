//
//  QuestionSession.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 15/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class QuestionSession: Object{
    @objc dynamic var id = UUID().uuidString
    dynamic var  questionSessions = List<QuestionSessionItem>()
    dynamic var optionSelectedList = List<OptionsSelected>()
    @objc dynamic var currentQuestionIndex = 0
    @objc dynamic var totalQuestions = 10
    @objc dynamic var sessionFinished = false
    @objc dynamic var questionInReviewSession = false
    
    convenience init(questions : [Question], questionsAmount : Int = 10) {
        self.init()
        self.totalQuestions = questionsAmount
        questions.forEach { (question) in
            questionSessions.append(QuestionSessionItem(questionId: question.id, question: question))
        }
        
    }
    
    convenience init(currentQuestionIndex: Int = 0, id: String, questionSessions:  List<QuestionSessionItem>, questionsAmount : Int = 10, sessionFinished: Bool = false, questionInReviewSession: Bool = false) {
        self.init()
        self.id = id
        self.currentQuestionIndex = currentQuestionIndex
        self.questionSessions = questionSessions
        self.totalQuestions = questionsAmount
        self.sessionFinished = sessionFinished
        self.questionInReviewSession = questionInReviewSession
    }
    
    
    convenience init (currentQuestionIndex: Int = 0, id: String){
        self.init()
        self.id = id
        self.currentQuestionIndex = currentQuestionIndex
    }
    
    required init() {
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func onSessionEnded( _ realm: Realm){
        let questionSessionResult = realm.objects(QuestionSession.self).first
        if let questionSession = questionSessionResult{
            try! realm.write{
                questionSession.sessionFinished = true
            }
        }
    }
    
    
    static func insertQuestionSession(questionSession: QuestionSession, realm: Realm){
        try! realm.write{
            realm.add(questionSession, update: .modified)
        }
    }
    
    static func onOptionSelected(forQuestionId questionId : String, option:Option, _ realm: Realm){
        let questionSession = realm.objects(QuestionSession.self).first
        var optionSelect : OptionsSelected? = nil
        for option in questionSession!.optionSelectedList {
            if option.id == questionId  {
                optionSelect = option
            }
        }
        
        if let optionSelected = optionSelect {
            try! realm.write{
                optionSelected.optionId = option.id ?? ""
                optionSelected.isCorrect = option.isCorrect
            }
        } else {
            let optionsSelected = OptionsSelected(id: questionId, optionId: option.id ?? "", isCorrect: option.isCorrect)
            try! realm.write{
                let item = realm.create(OptionsSelected.self, value: optionsSelected, update: .modified)
                questionSession?.optionSelectedList.append(item)
            }
        }
    }
    
    @discardableResult
    static func getQuestionSession(_ realm: Realm) -> QuestionSession? {
        let questionSession = realm.objects(QuestionSession.self).first
        guard let questionSessions = questionSession else {return nil}
        return questionSessions
    }
    
    @discardableResult
    static func getCurrentQuestionForSessionOnNext(_ realm: Realm) -> (QuestionSessionItem?, Int)? {
        if let questionSession = realm.objects(QuestionSession.self).first {
            guard  questionSession.currentQuestionIndex < questionSession.totalQuestions else {
                return nil
            }
            print("on next button \(questionSession.questionSessions)")
            let newIndex = questionSession.currentQuestionIndex + 1
            let sessionItem = questionSession.questionSessions[newIndex]
            try! realm.write{
                questionSession.currentQuestionIndex = newIndex
            }
            return (sessionItem, newIndex)
        }
        return nil
    }
    
    @discardableResult
    static func getCurrentQuestionAndStateForSession(_ realm: Realm) -> (QuestionSessionItem?, Int, Int, [OptionsSelected])? {
        if let questionSession = realm.objects(QuestionSession.self).first {
            let sessionItem = questionSession.questionSessions[questionSession.currentQuestionIndex]
            var tempOptionsSelected : [OptionsSelected] = []
            questionSession.optionSelectedList.forEach{ option in
                tempOptionsSelected.append(option)
            }
            return (sessionItem, questionSession.currentQuestionIndex, questionSession.totalQuestions, tempOptionsSelected)
        }
        return nil
    }
    
    @discardableResult
    static func getCurrentQuestionForSessionOnPrev(_ realm: Realm) -> (QuestionSessionItem?, Int)? {
        if let questionSession = realm.objects(QuestionSession.self).first {
            guard  questionSession.currentQuestionIndex > 0 else {
                return nil
            }
            let newIndex = questionSession.currentQuestionIndex - 1
            let sessionItem = questionSession.questionSessions[newIndex]
            try! realm.write{
               questionSession.currentQuestionIndex = newIndex
            }
            return (sessionItem, newIndex)
        }
        return nil
    }
    
    @discardableResult
    static func getSessionStats(_ realm: Realm) -> (Int, Int)? {
        var totalCorrect = 0
        if let questionSession = realm.objects(QuestionSession.self).first {
            for sessionItem in questionSession.optionSelectedList {
                if sessionItem.isCorrect {
                    totalCorrect = totalCorrect + 1
                }
            }
            return (totalCorrect, questionSession.totalQuestions)
        }
        
        return nil
    }
    static func resetSession(_ realm: Realm) {
        if let questionSession = realm.objects(QuestionSession.self).first {
            
            try! realm.write{
                questionSession.optionSelectedList = List<OptionsSelected>()
            }
        }
    }
    
}
