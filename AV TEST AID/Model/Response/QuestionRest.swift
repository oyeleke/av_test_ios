//
//  QuestionResponse.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 26/06/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation

struct QuestionRest: Codable {
    let _id : String
    let text: String?
    let explanation : String?
    let profession: Profession
    let topic: TopicRest
    let options: [OptionsRest]
    
    private enum Codingkeys: String, CodingKey {
        case _id = "_id"
        case text
        case explanation
        case profession
        case topic
        case options
    }
}
