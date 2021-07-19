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
    @objc dynamic var isCorrect = false
    
    override required init() {
    }
    
    convenience init(questionId: String) {
        self.init()
        self.questionId = questionId
    }
    
    convenience init(questionId: String, optionSelectedId: String, isCorrect: Bool) {
        self.init()
        self.questionId = questionId
        self.optionSelectedId = optionSelectedId
        self.isCorrect = isCorrect
    }
    
    override static func primaryKey() -> String? {
        return "questionId"
    }
}
