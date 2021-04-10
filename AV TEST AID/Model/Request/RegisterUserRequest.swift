//
// Created by Efe Ejemudaro on 05/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct RegisterUserRequest: Codable {
    var email: String
    var firstName: String
    var lastName: String
    var password: String

    private enum CodingKeys: String, CodingKey {
        case email
        case firstName
        case lastName
        case password
    }
}