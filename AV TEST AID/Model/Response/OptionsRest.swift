//
//  OptionsRest.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 26/06/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation

struct OptionsRest: Codable {
    
    let isCorrect : Bool
    let _id: String
    let text: String
    
    private enum CodingKeys: String, CodingKey{
        case _id = "_id"
        case isCorrect
        case text
    }
}
