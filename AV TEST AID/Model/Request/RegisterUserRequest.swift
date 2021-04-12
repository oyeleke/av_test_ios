//
// Created by Efe Ejemudaro on 05/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct RegisterUserRequest: Codable {

    let email: String
    let firstName: String
    let lastName: String
    let password: String

    private enum CodingKeys: String, CodingKey {
        case email
        case firstName
        case lastName
        case password
    }
}