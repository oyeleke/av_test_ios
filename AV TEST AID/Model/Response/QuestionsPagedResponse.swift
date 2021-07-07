//
//  QuestionsPagedResponse.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 26/06/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation


struct QuestionsPagedResponse: Codable {
    let totalPages: Int
    let questions : [QuestionRest]
    let currentPage: Int
    let total: Int
    let limit: Int
    
    private enum CodingKeys: String, CodingKey{
        case totalPages
        case questions
        case currentPage
        case total
        case limit
    }
}
