//
//  Options.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 26/06/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

class Option : Object{
    dynamic var isCorrect : Bool = false
      @objc dynamic var id: String?
      @objc dynamic var text: String?
    
    convenience init(optionsRest: OptionsRest) {
        self.init()
        self.isCorrect = optionsRest.isCorrect
        self.id = optionsRest._id
        self.text = optionsRest.text
    }
    
    override required init() {
        
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
