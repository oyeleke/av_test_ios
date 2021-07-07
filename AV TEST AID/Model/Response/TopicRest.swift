//
//  TopicRest.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 06/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation

struct TopicRest: Codable {

    let id: String
    let name: String

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }

}
