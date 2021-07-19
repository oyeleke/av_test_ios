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
    @objc dynamic var currentQuestionIndex = 0
    @objc dynamic var questionsAmount = 10
    @objc dynamic var sessionFinished = false
    
    convenience init(questions : [Question], questionsAmount : Int = 10) {
        self.init()
        self.questionsAmount = questionsAmount
        questions.forEach { (question) in
            questionSessions.append(QuestionSessionItem(questionId: question.id))
        }
        
    }
    
    convenience init(currentQuestionIndex: Int, id: String, questionSessions:  List<QuestionSessionItem>, questionsAmount : Int = 10, sessionFinished: Bool = false) {
        self.init()
        self.id = id
        self.currentQuestionIndex = currentQuestionIndex
        self.questionSessions = questionSessions
        self.questionsAmount = questionsAmount
        self.sessionFinished = sessionFinished
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
    
    
    static func onOptionSelected(forQuestionId: String, option:Option, _ realm: Realm){
        let questionSessionItem = QuestionSessionItem(questionId: forQuestionId, optionSelectedId: option.id!, isCorrect: option.isCorrect)
        try! realm.write{
            realm.add(questionSessionItem, update: .modified)
        }
    }
    
    @discardableResult
    static func getCurrentQuestionForSessionOnNext(_ realm: Realm) -> Question? {
        if let questionSession = realm.objects(QuestionSession.self).first {
            guard  questionSession.currentQuestionIndex < questionSession.questionsAmount else {
                return nil
            }
            
            let sessionItem = questionSession.questionSessions[questionSession.currentQuestionIndex]
            
            let question = Question.getQuestion(withQuestionId: sessionItem.questionId ?? "", realm)
            
            let session = QuestionSession(currentQuestionIndex: questionSession.currentQuestionIndex + 1, id: questionSession.id, questionSessions: questionSession.questionSessions)
            
            try! realm.write{
                realm.add(session, update: .modified)
            }
            
            return question
        }
        
        return nil
    }
    
    @discardableResult
    static func getCurrentQuestionForSessionOnPrev(_ realm: Realm) -> Question? {
        if let questionSession = realm.objects(QuestionSession.self).first {
            guard  questionSession.currentQuestionIndex > 0 else {
                return nil
            }
           
            let sessionItem = questionSession.questionSessions[questionSession.currentQuestionIndex]
            
            let question = Question.getQuestion(withQuestionId: sessionItem.questionId ?? "", realm)
            
            let session = QuestionSession(currentQuestionIndex: questionSession.currentQuestionIndex - 1, id: questionSession.id, questionSessions: questionSession.questionSessions)
            
            try! realm.write{
                realm.add(session, update: .modified)
            }
            
            return question
        }
        
        return nil
    }
    
    @discardableResult
    static func getFinalScorePercentage(_ realm: Realm) -> Double {
        var totalCorrect = 0
        var finalScore = 0.0
        
        if let questionSession = realm.objects(QuestionSession.self).first {
            for sessionItem in questionSession.questionSessions {
                if sessionItem.isCorrect {
                    totalCorrect = totalCorrect + 1
                }
            }
            
            finalScore = Double(totalCorrect / questionSession.questionsAmount)
            return finalScore
        }
        
        return finalScore
    }
    
}
