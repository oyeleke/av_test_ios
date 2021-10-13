//
//  QuestionInSession.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 30/09/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class OptionsSelected: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var optionId = ""
    @objc dynamic var isCorrect = false
    
    convenience init(id: String, optionId: String, isCorrect: Bool) {
        self.init()
        self.id = id
        self.optionId = optionId
        self.isCorrect = isCorrect
    }
    
    override static func primaryKey() -> String? {
         return "id"
     }
}
