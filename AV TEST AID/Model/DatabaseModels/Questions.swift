//
//  Questions.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 23/06/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class Question: Object {
    @objc dynamic var  id : String = ""
    @objc dynamic var  text: String?
    @objc dynamic var  explanation : String?
    @objc dynamic var  profession: String?
    @objc dynamic var  topic: String?
    dynamic var  options = List<Option>()
    
     convenience init(questionRest: QuestionRest) {
        self.init()
        self.id = questionRest._id
        self.text = questionRest.text
        self.explanation = questionRest.explanation
        self.profession = questionRest.profession.id
        self.topic = questionRest.topic.id
        questionRest.options.forEach { (value) in
            options.append(Option(optionsRest: value))
        }
    }
    
    required init() {
    }
    
    static func insertQuestions(questions: [Question], realm: Realm){
        try! realm.write{
            realm.add(questions)
        }
    }
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
//    func getPracticeQuestion(forProfessionId: String) -> [Question]{
//        
//    }
}

