//
// Created by Efe Ejemudaro on 15/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct Profession: Codable {

    let id: String
    let name: String

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }

}
