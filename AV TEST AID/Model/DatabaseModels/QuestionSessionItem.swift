//
//  QuestionSession.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 15/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class QuestionSessionItem : Object{
    @objc dynamic var optionSelectedId: String?
    @objc dynamic var questionId: String?
    @objc dynamic var question: Question?
    @objc dynamic var optionIsCorrect = false

    
    override required init() {
    }
    
    convenience init(questionId: String, question: Question) {
        self.init()
        self.questionId = questionId
        self.question = question
    }
    
    convenience init(questionId: String, optionSelectedId: String, optionIsCorrect: Bool) {
        self.init()
        self.questionId = questionId
        self.optionSelectedId = optionSelectedId
        self.optionIsCorrect = optionIsCorrect
    }
    
    override static func primaryKey() -> String? {
        return "questionId"
    }
}
