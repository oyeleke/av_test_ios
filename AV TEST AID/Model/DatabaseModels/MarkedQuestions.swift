//
//  MarkedQuestions.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 07/10/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class MarkedQuestions: Object {
    
    @objc dynamic var id : String = ""
    dynamic var questionsMarked = List<String>()
    
    
    convenience init (withStringId stringId : String = UUID.init().uuidString) {
        self.init()
        id = stringId 
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //returns true if the question has been marked, and false if the question has been removed
    @discardableResult
    static func onQuestionMarkedStateChanged(forQuestionWithId questionId: String, _ realm: Realm) -> MarkedQuestionStates{
        guard let markedQuestionEntity = realm.objects(MarkedQuestions.self).first else {
            return MarkedQuestionStates.ERROR
        }
        var questionHasBeenMarked = false
        var i = 0
        for id in markedQuestionEntity.questionsMarked {
            if questionId == id {
                questionHasBeenMarked = true
                break
            }
            i = i + 1
        }
        
        if questionHasBeenMarked {
            try! realm.write{
                markedQuestionEntity.questionsMarked.remove(at: i)
            }
            return MarkedQuestionStates.MARKED_QUESTION_REMOVED
        } else {
            try! realm.write{
                markedQuestionEntity.questionsMarked.append(questionId)
            }
            return MarkedQuestionStates.QUESTION_MARKED
        }
    }
    
    
    static func createMarkedQuestionsInRealmIfitDoesNotExist(_ realm: Realm){
        if  realm.objects(MarkedQuestions.self).first != nil {
            return
        } else {
            try! realm.write{
                let markedQuestions = MarkedQuestions()
                realm.add(markedQuestions)
            }
        }
    }
    
    @discardableResult
    static func getAllMarkedQuestionsAsSet(_ realm: Realm) -> Set<String> {
        guard let markedQuestionEntity = realm.objects(MarkedQuestions.self).first else {
            return []
        }
        var dict : Set<String> = []
        
        for id in markedQuestionEntity.questionsMarked {
            dict.insert(id)
        }
        print("==================================")
        print(markedQuestionEntity.questionsMarked)
        print("==================================")
        return dict
    }
    
    @discardableResult
    static func getAllMarkedQuestions(_ realm: Realm) -> List<String> {
        guard let markedQuestionEntity = realm.objects(MarkedQuestions.self).first else {
            return List<String>()
        }
        
        return markedQuestionEntity.questionsMarked
    }
    
    
}
